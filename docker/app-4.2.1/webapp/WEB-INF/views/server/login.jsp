<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<t:master>
<jsp:attribute name="pagecomment"><!-- HTTP/1.1 401 Unauthorized --></jsp:attribute>

<jsp:attribute name="extrahead">
<script type="text/javascript">
$(document).ready(function() { 
        $('#username').focus(); 
        $("#login").submit(function() {
            $(this).submit(function() {
                return false;
            });
            return true;
        });
    });


</script>
</jsp:attribute>

<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Login</jsp:attribute>

<jsp:body>
 <div id="login-form">
     
     <h2><spring:theme code="product.name"/> Login</h2>
     <div id="usage"><spring:theme code="indications.for.use" text=""/></div>
     <form method="post" action="/login" autocomplete="off" id="login">

         <div id="inputs">
             <label for="username"><spring:theme code="enter.name"/></label><input id="username" class="field" type="text" name="j_username"/>
             <br/>
             <label for="password"><spring:theme code="enter.password"/></label><input id="password" class="field" type="password" name="j_password"/>
             <br/>
             <input id="submit" type="submit" value="<spring:theme code="sign.in"/>"/>
             <c:if test="${param.error != null}">
                 <div id="error"><spring:theme code="login.failed"/></div>
             </c:if>
             <c:if test="${param.logout != null}">
                 <div id="message"><spring:theme code="logout.successful"/></div>
             </c:if>
             
         </div>
     </form>
 </div>
</jsp:body>
</t:master>
