/* ************************************************************************

   qooxdoo - the new era of web development

   http://qooxdoo.org

   Copyright:
     2007-2012 1&1 Internet AG, Germany, http://www.1und1.de

   License:
     LGPL: http://www.gnu.org/licenses/lgpl.html
     EPL: http://www.eclipse.org/org/documents/epl-v10.php
     See the LICENSE file in the project's top-level directory for details.

   Authors:
     * Martin Wittemann (martinwittemann)

************************************************************************ */

/**
 * testResolve-Class for testResolveing the single value binding
 */
qx.Class.define("qx.test.data.singlevalue.Resolve",
{
  extend : qx.dev.unit.TestCase,

  members :
  {
    testResolveDepth1 : function() {
      var model = qx.data.marshal.Json.createModel({a: 12});
      this.assertEquals(12, qx.data.SingleValueBinding.resolvePropertyChain(model, "a"));
      model.dispose();
    },


    testResolveDepth2 : function() {
      var model = qx.data.marshal.Json.createModel({a: {b:12}});
      this.assertEquals(12, qx.data.SingleValueBinding.resolvePropertyChain(model, "a.b"));
      model.dispose();
    },


    testResolveDepthHuge : function() {
      var model = qx.data.marshal.Json.createModel({a: {b: {c: {d: {e: {f: 12}}}}}});
      this.assertEquals(12, qx.data.SingleValueBinding.resolvePropertyChain(model, "a.b.c.d.e.f"));
      model.dispose();
    },


    testResolveWithArray : function() {
      var model = qx.data.marshal.Json.createModel({a: {b: [{c: 12}]}});
      this.assertEquals(12, qx.data.SingleValueBinding.resolvePropertyChain(model, "a.b[0].c"));
      model.dispose();
    },


    testResolveNotExistant : function() {
      var model = qx.data.marshal.Json.createModel({a: 12});
      this.assertException(function() {
        this.assertEquals(12, qx.data.SingleValueBinding.resolvePropertyChain(model, "b"));
      })
      model.dispose();
    }
  }
});