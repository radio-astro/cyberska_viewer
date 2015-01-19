<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Server Configuration</jsp:attribute>

<jsp:body>
<h1 class="highlight">Configuration Backups</h1>

Only the following configuration files will be saved:
<ul>
	<c:forEach var="configFile" items="${configFileNames}">
	<li>${configFile}</li>
    </c:forEach>
</ul>

<form:form enctype="multipart/form-data">
    <p>
        <input type="submit" name="backup" value="Save New Backup" class="button"/>
    </p>
    <p>
        <c:forEach var="backup" items="${backups}">
        <input type="radio" name="timestamp" value="${backup.time}" checked="checked"/>${backup}<br/>
        </c:forEach>
    </p>
    <p>
        <input type="submit" name="restore" value="Restore Selected Backup" class="button"/>
        <input type="submit" name="delete" value="Delete Selected Backup" class="button"/>
        <input type="submit" name="export" value="Export Selected Backup" class="button"/>
    </p>
    <p>
        <input type="submit" name="import" value="Import Backup From" class="button"/>
        <input type="file" name="file" size="35" accept="application/zip" style="color:black;"/>
    </p>
</form:form>

<p class="success">
    <c:out value="${message}"/>
</p>

<p class="failure">
    <c:out value="${error}"/>
</p>
</jsp:body>
</t:master>
