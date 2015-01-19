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
</div>
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