<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Error Page</jsp:attribute>
<jsp:body>
<h2 class="highlight"><spring:theme code="product.name"/> Error Page</h2>
<div class="content" style="padding-left:50px;">
    <h1>${code}&#160;${description}</h1>
    <p>${reason}</p>
    <p>${uri}</p>
    <p>${date}</p>
    <p>${type}</p>
</div>
</jsp:body>
</t:master>
