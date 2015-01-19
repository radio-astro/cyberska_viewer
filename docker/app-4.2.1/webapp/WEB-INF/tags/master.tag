<%@ tag description="Overall Page template" pageEncoding="UTF-8"%>
<%@ attribute name="pagecomment" fragment="true" %>
<%@ attribute name="pagetitle" fragment="true" %>
<%@ attribute name="extrahead" fragment="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><jsp:invoke fragment="pagecomment"/>
<html>
<head>

<link rel="shortcut icon" href="<spring:theme code="favicon.path" text="/favicon.ico"/>"/>

<link rel="stylesheet" type="text/css" href='/themes/pureweb/pureweb.css'/>
<link rel="stylesheet" type="text/css" href='<spring:theme code="style.css"/>'/>
<link rel="stylesheet" type="text/css" href='/lib/jquery/jquery-ui-1.8.6.darkhive.css'/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<script type="text/javascript" src="/lib/jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/lib/jquery/jquery-ui-1.8.6.min.js"></script>
<script type="text/javascript" src="/pureweb.js"></script>

<title><jsp:invoke fragment="pagetitle"/></title>

<script type="text/javascript">
$(function() {
	$(".tabs").tabs();
});

$(function() {
	$("#dialog").dialog({ autoOpen: false, modal: true });
});

$(function() {
	$(".button").button();
	$("#submit").button();
});

</script>
<jsp:invoke fragment="extrahead"/>
</head>
<body>
<div id="content">
<div id="header">
<div id="toplinks">
<sec:authorize access="isFullyAuthenticated()">

<sec:authorize access="isFullyAuthenticated()">
<a href="/pureweb/server/links">Apps</a> | 
</sec:authorize>

<sec:authorize access="hasRole('ROLE_PUREWEB_SERVER_MONITOR') or hasRole('ROLE_PUREWEB_SERVER_ADMIN')">
<a href="/pureweb/server/status">Status</a> |
<a href="/pureweb/server/logs">Logs</a> |
<a href="/pureweb/server/info">Version</a> |
<a href="/pureweb/server/support">Support</a> |
<a href="/pureweb/server/license">License</a> |
</sec:authorize>

<sec:authorize access="hasRole('ROLE_PUREWEB_SERVER_ADMIN')">
<a href="/pureweb/config/plugins">Configuration</a> | 
<c:forEach var="plugin" items="${configurationPlugins}">
<a href="${plugin.link}">${plugin.name}</a> | 
</c:forEach>
</sec:authorize>

<!-- | <a href="#" onclick="javascript:$('#dialog').dialog('open')">Help</a> -->
<a href="/pureweb/server/logout">Logout (<sec:authentication property="principal.username" />)</a>
 
</sec:authorize>

</div>
</div>
<sec:authorize access="hasRole('ROLE_PUREWEB_SERVER_MONITOR') or hasRole('ROLE_PUREWEB_SERVER_ADMIN')">
<c:forEach var="warning" items="${configurationWarnings}">
<div class="failure">WARNING: ${warning}</div>
</c:forEach>
</sec:authorize>

<jsp:doBody/>
<div id="footer">
<spring:theme code="copyright.notice"/><br>
</div>
</div>
<div id="dialog" title="Help">
<p>Help is currently not implemented</p>
</div>
</body>
</html>
