<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Server Logs</jsp:attribute>
<jsp:body>
<h2 class="highlight"><spring:theme code="product.name"/> Server Logs</h2>
<ul>
<c:forEach var="file" items="${logfiles}">
    <li><a href="logs/${file.name}">${file.name}</a> (${file.length}KiB; last modified ${file.lastModifiedDate})</li>
</c:forEach>
</ul>
</jsp:body>
</t:master>
