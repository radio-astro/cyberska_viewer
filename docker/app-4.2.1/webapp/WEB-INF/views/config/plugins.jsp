<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Server Configuration</jsp:attribute>
<jsp:body>
<h1 class="highlight"><spring:theme code="product.name"/> Server Configuration</h1>

<c:forEach var="plugin" items="${plugins}">
    <c:if test="${plugin.loaded && plugin.started}">
        <span class="success">
        <h2>
            <c:out value="${plugin.servletName}"/>
            <c:if test="${plugin.reloadRequired}">(reload required)</c:if>
        </h2>
        <ul>
            <c:if test="${plugin.properties != null}">
            <li><a href="plugins/<c:out value="${plugin.servletName}"/>/properties"><c:out value="${plugin.properties.name}"/></a></li>
            </c:if>
            <li><a href="plugins/<c:out value="${plugin.servletName}"/>/context"><c:out value="${plugin.configuration.name}"/></a></li>

            <c:forEach var="file" items="${plugin.configurableFiles}" varStatus="status">
                <li><a href="plugins/<c:out value="${plugin.servletName}"/>/configfiles/${status.index}"><c:out value="${file}"/></a></li>
            </c:forEach>
        </ul>
        </span>
    </c:if>
    <c:if test="${!plugin.loaded || !plugin.started}">
        <span class="failure">
        <h2>
            <c:out value="${plugin.servletName}"/>
            <c:if test="${plugin.reloadRequired}">(reload required)</c:if>
        </h2>
        <ul>
            <c:if test="${plugin.properties != null}">
            <li><a class="failure" href="plugins/<c:out value="${plugin.servletName}"/>/properties"><c:out value="${plugin.properties.name}"/></a></li>
            </c:if>
            <li><a class="failure" href="plugins/<c:out value="${plugin.servletName}"/>/context"><c:out value="${plugin.configuration.name}"/></a></li>

            <c:forEach var="file" items="${plugin.configurableFiles}" varStatus="status">
                <li><a href="plugins/<c:out value="${plugin.servletName}"/>/configfiles/${status.index}"><c:out value="${file}"/></a></li>
            </c:forEach>
        </ul>

        Errors:
        <ul>
            <c:forEach var="error" items="${plugin.errors}">
            <li class="failure"><c:out value="${error}"/></li>
            </c:forEach>
        </ul>
        </span>
    </c:if>    
</c:forEach>

<form:form>
    <input type="submit" name="plugins" value="Reload Plugins" class="button"/>
</form:form>

<h1 class="highlight">Logging Configuration</h1>

<c:if test="${logback.configured}">
    <span class="success">
    <h2>
        logging
        <c:if test="${logback.reloadRequired}">(reload required)</c:if>
    </h2>
    <ul>
        <li><a href="logging/properties">logback.properties</a></li>
        <li><a href="logging/context">logback.xml</a></li>
    </ul>
    </span>
</c:if>
<c:if test="${!logback.configured}">
    <span class="failure">
    <h2>
        logging
        <c:if test="${logback.reloadRequired}">(reload required)</c:if>
    </h2>
    <ul>
        <li><a class="failure" href="logging/properties">logback.properties</a></li>
        <li><a class="failure" href="logging/context">logback.xml</a></li>
    </ul>

    <c:if test="${!empty logback.errors}">
    Errors:
    <ul>
        <c:forEach var="error" items="${logback.errors}">
        <li class="failure"><c:out value="${error}"/></li>
        </c:forEach>
    </ul>
    </c:if>
    </span>
</c:if>    

<form:form>
    <input type="submit" name="logging" value="Reload Logging" class="button"/>
</form:form>

<h1 class="highlight">System Configuration</h1>

<h2>
    Settings
    <c:if test="${purewebContext.reloadRequired}">(reload required)</c:if>
</h2>

<ul>
    <li><a href="clientaccesspolicy.xml">clientaccesspolicy.xml</a></li>
    <li><a href="crossdomain.xml">crossdomain.xml</a></li>
    <li><a href="pureweb-context.xml">pureweb-context.xml</a></li>
</ul>

<h2>
    Administration
    <c:if test="${systemConfig.reloadRequired}">(reload required)</c:if>
</h2>

<ul>
    <li><a href="/pureweb/config/users">Change Administrator Password</a></li>
    <li><a href="/pureweb/config/backups">Backup/Restore Configuration</a></li>
    <li><a href="/pureweb/config/serversupport">Change Server Support Information</a></li>
</ul>

<form:form>
    <input type="submit" name="system" value="Reload Pureweb System" class="button"/>
</form:form>
</jsp:body>
</t:master>
