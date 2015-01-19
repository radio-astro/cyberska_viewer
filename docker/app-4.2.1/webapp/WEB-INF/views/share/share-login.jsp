<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<t:master>


<jsp:attribute name="extrahead">

<!-- For SL detection -->
<script type="text/javascript" src="/Silverlight.js"></script>
<script type="text/javascript">
$(document).ready(function() { 
    $('#password').focus(); 
    $("#login").submit(function() {
        $(this).submit(function() {
            return false;
        });
        return true;
    });
});
</script>
</jsp:attribute>

<jsp:attribute name="pagetitle"><spring:theme code="product.name"/></jsp:attribute>

<jsp:body>
 <div id="login-form">
     <h2>PureWeb Collaboration Login</h2>

     <form method="post" action="/pureweb/share/${param.shareKey}" autocomplete="off" id="login">
         <div id="inputs">
	         <div id="downloadLinks" style="display:block; margin-left:3%; margin-bottom:20px;">
				<div id="download_link_${mobile}">
					<c:if test='${mobile == "ios" && availableClients[mobile] != ""}'>
						<a href="${availableClients[mobile]}" target="itunes_store"><img src="/images/appstore.gif" alt="Download iOS Client" style="border: 0;"/></a>
					</c:if>
					<c:if test='${mobile == "android" && availableClients[mobile] != ""}'>
						<a href="${availableClients[mobile]}" target="android_market"><img src="/images/android.png" alt="Download Android Client" style="border: 0;"/></a>
					</c:if>
				</div>
			 </div>
			<div id="clients">
	         	 <label for="client">Preferred client:</label>
	         	 <select id="client" name="client">

	         	 <c:forEach var="client" items="${availableClients}">
	         	 <c:choose>
					<c:when test='${defaultClient == client}'>
						<option selected value="${client.key}">${client.key}</option>
					</c:when>
					<c:otherwise>
						<option value="${client.key}">${client.key}</option>
					</c:otherwise>
				</c:choose>
				 </c:forEach>
	         	 </select>
         	 </div>

             <label for="password">Enter Password:</label><input id="password" class="field" type="password" name="share_password"/>
             <br/>
             <input id="submit" type="submit" value="Sign In"/>
             <c:if test="${param.error != null}">
                 <div id="error">Login failed</div>
             </c:if>
         </div>
     </form>
 </div>
</jsp:body>
</t:master>
