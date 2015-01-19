#!/usr/bin/env python
# -*- coding: utf-8 -*-
################################################################################
#
#  qooxdoo - the new era of web development
#
#  http://qooxdoo.org
#
#  Copyright:
#    2006-2012 1&1 Internet AG, Germany, http://www.1und1.de
#
#  License:
#    LGPL: http://www.gnu.org/licenses/lgpl.html
#    EPL: http://www.eclipse.org/org/documents/epl-v10.php
#    See the LICENSE file in the project's top-level directory for details.
#
#  Authors:
#    * Thomas Herchenroeder (thron7)
#
################################################################################

##
# Reduce conditional expressions that are decidable. Requires .evaluated.
# Modifies tree structure.
##

import os, sys, re, types, operator, functools as func
from ecmascript.frontend import treeutil, treegenerator
from ecmascript.frontend.treegenerator  import symbol
from ecmascript.frontend import Scanner
from misc import util

class ConditionReducer(treeutil.NodeVisitor):

    def __init__(self, root_node):
        super(ConditionReducer, self).__init__()
        self.root_node = root_node


    def visit_loop(self, node):
        loop_type = node.get("loopType")
        if loop_type == "IF":
            cond_node = node.children[0]
            if hasattr(cond_node, "evaluated") and cond_node.evaluated!=():
                #self._rewrite_if(node, bool(cond_node.evaluated))
                treeutil.inlineIfStatement(node, bool(cond_node.evaluated))
        for child in node.children:
            self.visit(child)

    def visit_operation(self, node): # catch HOOK operations
        op_type = node.get("operator")
        if op_type == "HOOK":
            cond_node = node.children[0]
            if hasattr(cond_node, "evaluated") and cond_node.evaluated!=():
                self._rewrite_hook(node, bool(cond_node.evaluated))
        for child in node.children:
            self.visit(child)


    def _rewrite_if(self, if_node, cond_val):
        if cond_val:
            # use then branch
            replacement = if_node.children[1] 
            # rescue vardecl's from else branch, so these vars don't become global
            # if used elsewhere, but *don't* rescue their init's.
            if len(if_node.children) == 3:
                extracted_vars = extract_vars(if_node.children[2])
                add_vars(replacement, extracted_vars)
        else:
            # use else branch or empty
            if len(if_node.children) == 3:
                replacement = if_node.children[2]
            else:
                # don't leave single-statement parent loops empty (if_node.parent.type not in ("block", "file")
                replacement = treegenerator.symbol("block")(if_node.get("line"), if_node.get("column"))
            # rescue vardecl's from then branch
            extracted_vars = extract_vars(if_node.children[1])
            add_vars(replacement, extracted_vars)
        if_node.parent.replaceChild(if_node, replacement)

    def _rewrite_hook(self, hook_node, cond_val):
        if cond_val: # use then expr
            replacement = hook_node.children[1]
        else: # use else expr
            replacement = hook_node.children[2]
        hook_node.parent.replaceChild(hook_node, replacement)

# - ---------------------------------------------------------------------------

def reduce(node):
    reducer = ConditionReducer(node)
    reducer.visit(node)


# - ---------------------------------------------------------------------------
# Newer approach:
# A general AST reducer.
#
# Computes new, pot. reduced tree.
# Does a post-order recursion (children first).

class ASTReducer(treeutil.NodeVisitor):

    def __init__(self, root_node):
        super(ASTReducer, self).__init__()
        self.root_node = root_node
        self.operations = self._init_operations()

    def _init_operations(self):
        operations = {}
        types_Number = (types.IntType, types.LongType, types.FloatType, types.BooleanType)

        def opr(operation, op1, op2):
            if all([isinstance(x, types_Number) for x in (op1, op2)]):
                return operation(op1, op2)
            else:
                return ()
        operations['MUL'] = func.partial(opr, operator.mul)
        operations['DIV'] = func.partial(opr, operator.truediv)
        operations['MOD'] = func.partial(opr, operator.mod)

        # Have to distinguish between prefix and infix +/-
        def opr(operation, op1, op2=()):
            result = ()
            if isinstance(op1, types_Number): 
                # prefix +/-
                if op2==():
                    if operation=='+':
                        result = operator.pos(op1)
                    elif operation=='-':
                        result = operator.neg(op1)
                elif isinstance(op2, types_Number):
                    if operation=='+':
                        result = operator.add(op1,op2)
                    elif operation=='-':
                        result = operator.sub(op1,op2)
            # string '+'
            elif operation=='+' and all([isinstance(x,types.StringTypes) for x in (op1,op2)]):
                result = operator.add(op1,op2)
            return result
        operations['ADD'] = func.partial(opr, '+')
        operations['SUB'] = func.partial(opr, '-')
        #operations['INC'] -- only on vars!
        #operations['DEC'] -- only on vars!

        operations['EQ']   = operator.eq
        operations['SHEQ'] = operator.eq
        operations['NE']   = operator.ne
        operations['SHNE'] = operator.ne

        operations['LT'] = operator.lt
        operations['LE'] = operator.le
        operations['GT'] = operator.gt
        operations['GE'] = operator.ge

        operations['NOT'] = operator.not_
        operations['AND'] = lambda x,y: x and y
        operations['OR']  = lambda x,y: x or y

        # bit operations only operate on 32-bit integers in JS
        operations['BITAND'] = operator.and_
        operations['BITOR']  = operator.or_
        operations['BITXOR'] = operator.xor
        operations['BITNOT'] = operator.inv

        # second shift operand must be in 0..31 in JS
        def opr(operation, op1, op2):
            op2 = (op2 & 0x1f)  # coerce to 0..31
            return operation(op1,op2)
        operations['LSH']  = func.partial(opr, operator.lshift)

        #def rsh(op1, op2): # http://bit.ly/13v4Adq
        #    sign = (op1 >> 31) & 1 
        #    if sign:
        #       fills = ((sign << op2) - 1) << (32 - op2)
        #    else:
        #       fills = 0
        #    return ((op1 & 0xffffffff) >> op2) | fills
        #operations['RSH']  = func.partial(opr, rsh)
        operations['RSH']  = func.partial(opr, operator.rshift)

        def ursh(op1, op2):
            op1 = (op1 & 0xffffffff)  # coerce to 32-bit int
            return operator.rshift(op1, op2) # Python .rshift does 0 fill
        operations['URSH'] = func.partial(opr, ursh)

        # ?:
        def opr(op1, op2, op3):
            return op2 if bool(op1) else op3
        operations['HOOK'] = opr

        return operations
        # end:_init_operations


    def visit(self, node):
        # reduce children
        nchilds = []
        for child in node.children:
            nchild = self.visit(child)
            nchilds.append(nchild)

        nnode = node
        nnode.children = []
        for cld in nchilds:
            nnode.addChild(cld)
        if hasattr(self, "visit_"+node.type):
            nnode = getattr(self, "visit_"+node.type)(nnode)
        return nnode

    # - Type-specific methods don't need to recurse anymore!

    def visit_constant(self, node):
        constvalue = node.get("value")
        consttype = node.get("constantType")

        value = ()  # the empty tuple indicates unevaluated
        if consttype == "number":
            constdetail = node.get("detail")
            if constdetail == "int":
                value = util.parseInt(constvalue)
            elif constdetail == "float":
                value = float(constvalue)
        elif consttype == "string":
            value = constvalue
        elif consttype == "boolean":
            value = {"true":True, "false":False}[constvalue]
        elif consttype == "null":
            value = None

        if value!=():
            node.evaluated = value
        return node

    def visit_operation(self, node):
        operator = node.get("operator")
        arity = len(node.children)
        if arity == 1:
            nnode = self._visit_monadic(node, operator)
        elif arity == 2:
            nnode = self._visit_dyadic(node, operator)
        elif arity == 3:
            nnode = self._visit_triadic(node, operator)
        return nnode

    ##
    # IF
    def visit_loop(self, node):
        loop_type = node.get("loopType")
        nnode = node
        if loop_type == "IF":
            cond_node = node.children[0]
            if hasattr(cond_node, "evaluated"):
                value = bool(cond_node.evaluated)
                nnode, is_empty = treeutil.inlineIfStatement(node, value, inPlace=False)
        return nnode

    ##
    # (group)
    def visit_group(self, node):
        nnode = node
        # can only reduce "(3)" or "('foo')" or "(true)" etc.
        if len(node.children)==1:
            expr_node = node.children[0]
            if expr_node.type == 'constant': # must have been evaluated by pre-order
                nnode = expr_node
        return nnode


    def _visit_monadic(self, node, operator):
        op1 = node.children[0]
        nnode = node
        if hasattr(op1, "evaluated"):
            if operator in self.operations:
                evaluated = self.operations[operator](op1.evaluated)
                if evaluated!=():
                    nnode = symbol("constant")(
                        node.get("line"), node.get("column"))
                    set_node_type_from_value(nnode, evaluated)
                    nnode.evaluated = evaluated
        return nnode

    def _visit_dyadic(self, node, operator):
        op1 = node.children[0]
        op2 = node.children[1]
        nnode = node
        if operator in self.operations:
            if operator in ['AND', 'OR'] and hasattr(op1, 'evaluated'): # short-circuit ops
                evaluated = self.operations[operator](op1.evaluated, op2)
                nnode = op1 if evaluated==op1.evaluated else op2
            elif all([hasattr(x, 'evaluated') for x in (op1, op2)]):
                evaluated = self.operations[operator](op1.evaluated, op2.evaluated)
                if evaluated!=():
                    nnode = symbol("constant")(
                        node.get("line"), node.get("column"))
                    set_node_type_from_value(nnode, evaluated)
                    nnode.evaluated = evaluated
        return nnode

    ##
    # HOOK
    def _visit_triadic(self, node, operator):
        op1 = node.children[0]
        op2 = node.children[1]
        op3 = node.children[2]
        nnode = node
        if operator in self.operations:
            # to evaluate HOOK, it is enough to evaluate the condition
            if operator == "HOOK" and hasattr(op1, 'evaluated'):
                nnode = self.operations[operator](op1.evaluated, op2, op3)
        return nnode


##
# Take a Python value and init a constant node with it, setting the node's "constantType"
#
def set_node_type_from_value(valueNode, value):
    valueNode.set("value", str(value))  # init value attrib
    if isinstance(value, types.StringTypes):
        valueNode.set("constantType","string")
        quotes, escaped_value = escape_quotes(str(value))
        valueNode.set("value", escaped_value)
        valueNode.set("detail", quotes)
    # this has to come first, as isinstance(True, types.IntType) is also true!
    elif isinstance(value, types.BooleanType):
        valueNode.set("constantType","boolean")
        valueNode.set("value", str(value).lower())
    elif isinstance(value, (types.IntType, types.LongType)):
        valueNode.set("constantType","number")
        valueNode.set("detail", "int")
    elif isinstance(value, types.FloatType):
        valueNode.set("constantType","number")
        valueNode.set("detail", "float")
    elif isinstance(value, types.NoneType):
        valueNode.set("constantType","null")
        valueNode.set("value", "null")
    else:
        raise ValueError("Illegal value for JS constant: %s" % str(value))
    return valueNode

##
# Determine the quoting to be used on that string in code ('singlequotes',
# 'doublequotes'), and escape pot. embedded quotes correspondingly.
# (The string might result from a concat operation that combined differently
# quoted strings, like 'fo"o"bar' + "ba"\z\"boing").
#
def escape_quotes(s):
    quotes = 'singlequotes'  # aribtrary choice
    result = s
    # only if we have embedded quotes we have to check escaping
    if "'" in s:
        result = []
        chunks = s.split("'")
        for chunk in chunks[:-1]:
            result.append(chunk)
            if not Scanner.is_last_escaped(chunk + "'"):
                result.append('\\')
            result.append("'")
        result.append(chunks[-1])
        result = u''.join(result)
    return quotes, result


# - ---------------------------------------------------------------------------

def ast_reduce(node):
    reducer = ASTReducer(node)
    new_node = reducer.visit(node)
    return new_node
