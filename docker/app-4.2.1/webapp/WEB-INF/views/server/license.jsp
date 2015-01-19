<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Server Status Page</jsp:attribute>
<jsp:body>

<c:set var="license" value="${applicationScope['license']}" />


<div class="node">
<h3>License Details</h3>

<c:if test="${empty license}">
<p>This server is not correctly licensed.</p>
</c:if>

<c:if test="${!empty license}">

<table>
<tbody>
<tr><td>Version</td><td>${license.product}&nbsp;${license.version}</td><tr>
<tr><td>Customer</td><td>${license.customer}</td><tr>
<tr><td>Issuer</td><td>${license.issuer}</td><tr>
<tr><td>Expires</td><td>${license.expiration}</td><tr>
<tr><td>Type</td><td>${license.contract}</td><tr>
<tr><td>Users</td><td>${license.options}</td><tr>
</tbody>
</table>

</c:if>

</div>

</jsp:body>
</t:master>
