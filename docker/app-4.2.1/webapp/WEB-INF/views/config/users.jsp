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
<h1 class="highlight">Change Administrator Password</h1>

<form:form>

<table>
    <tr>
        <td style="text-align:right">Old Password:</td><td><input type="password" size="40" name="oldPassword" value/></td>
    </tr>
    <tr>
        <td style="text-align:right">New Password:</td><td><input type="password" size="40" name="newPassword1" value/></td>
    </tr>
    <tr>
        <td style="text-align:right">Confirm New Password:</td><td><input type="password" size="40" name="newPassword2" value/></td>
    </tr>
</table>

<p/>
<input type="submit" name="submit" value="Change Password" class="button"/>

</form:form>

<p class="success">
    <c:out value="${message}"/>
</p>

<p class="failure">
    <c:out value="${error}"/>
</p>
</jsp:body>
</t:master>
