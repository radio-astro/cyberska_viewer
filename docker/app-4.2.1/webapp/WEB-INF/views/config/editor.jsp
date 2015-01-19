<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Server Configuration</jsp:attribute>

<jsp:body>
<h1 class="highlight"><spring:theme code="product.name"/> Server Configuration</h1>

<p class="failure">
    <c:if test="${!empty errors}">
    Errors:
    <ul>
        <c:forEach var="error" items="${errors}">
        <li class="failure"><c:out value="${error}"/></li>
        </c:forEach>
    </ul>
    </c:if>
</p>


<form:form>
<textarea name="text" style="width:100%; background:#AAAAAA;" rows="24">
<c:out value="${text}"/>
</textarea>
<p/>
<input type="submit" name="save" value="Save" class="button"/>
<input type="submit" name="cancel" value="Cancel" class="button"/>
</form:form>
</jsp:body>
</t:master>
