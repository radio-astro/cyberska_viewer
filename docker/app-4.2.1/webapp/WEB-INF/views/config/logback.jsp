<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Logging Configuration</jsp:attribute>

<jsp:body>
<h1 class="highlight">Logging Configuration</h1>

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

<table>
    <tr>
        <th>Log</th>
        <th>Location</th>
        <th>History</th>
    </tr>
    <tr>
        <td>pureweb</td>
        <td><input type="text" size="40" name="pureweb.log" value="<c:out value='${properties["pureweb.log"]}'/>"/></td>
        <td><input type="text" size="4" maxlength="4" name="pureweb.history" value="<c:out value='${properties["pureweb.history"]}'/>"/> days</td>
    </tr>
    <tr>
        <td>error</td>
        <td><input type="text" size="40" name="error.log" value="<c:out value='${properties["error.log"]}'/>"/></td>
        <td><input type="text" size="4" maxlength="4" name="error.history" value="<c:out value='${properties["error.history"]}'/>"/> days</td>
    </tr>
    <tr>
        <td>activity</td>
        <td><input type="text" size="40" name="activity.log" value="<c:out value='${properties["activity.log"]}'/>"/></td>
        <td><input type="text" size="4" maxlength="4" name="activity.history" value="<c:out value='${properties["activity.history"]}'/>"/> days</td>
    </tr>
    <tr>
        <td>access</td>
        <td><input type="text" size="40" name="access.log" value="<c:out value='${properties["access.log"]}'/>"/></td>
        <td><input type="text" size="4" maxlength="4" name="access.history" value="<c:out value='${properties["access.history"]}'/>"/> days</td>
    </tr>
</table>

<p/>
<input type="submit" name="save" value="Save" class="button"/>
<input type="submit" name="cancel" value="Cancel" class="button"/>

</form:form>

</jsp:body>
</t:master>
