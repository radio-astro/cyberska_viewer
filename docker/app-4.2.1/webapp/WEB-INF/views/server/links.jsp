<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Applications Page</jsp:attribute>
<jsp:body>
<h2 class="highlight">Available Managed Applications</h2>
<c:forEach var="managedLink" items="${managedLinks}">
<div class="applauncher">
<a href='<c:out value='${managedLink.path}'/>'><img src='<c:out value="${managedLink.image}"/>' title='Launch <c:out value="${managedLink.name}"/>'/></a></td>
<div class="name"><c:out value="${managedLink.name}"/></div>
<div class="description"><c:out value="${managedLink.description}"/></div>

<c:choose>
    <c:when test="${empty managedLink.path}">
        <c:forEach var="clientLink" items="${managedLink.generatedLinks}">
           <div class="launchButton"><a href="<c:out value='${clientLink.value}'/>" class="button">Launch <c:out value="${clientLink.key}"/> </a></div>
         </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="launchButton"><a href="<c:out value='${managedLink.path}'/>" class="button">Launch </a></div>
    </c:otherwise>
</c:choose>

</div>
</c:forEach>


<h2 class="highlight">Queued Unmanaged Applications</h2>

<c:forEach var="unmanagedLink" items="${unmanagedLinks}">
<div class="applauncher">
<a href='<c:out value='${unmanagedLink.path}'/>'><img src='<c:out value="${unmanagedLink.image}"/>' title='Launch <c:out value="${unmanagedLink.name}"/>'/></a></td>
<div class="name"><c:out value="${unmanagedLink.name}"/></div>
<div class="description"><c:out value="${unmanagedLink.description}"/></div>

<c:choose>
    <c:when test="${empty unmanagedLink.path}">
         <c:forEach var="clientLink" items="${unmanagedLink.generatedLinks}">
           <div class="launchButton"><a href="<c:out value='${clientLink.value}'/>" class="button">Launch <c:out value="${clientLink.key}"/> </a></div>
         </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="launchButton"><a href="<c:out value='${unmanagedLink.path}'/>" class="button">Launch </a></div>
    </c:otherwise>
</c:choose>

</div>
</c:forEach>

</jsp:body>
</t:master>
