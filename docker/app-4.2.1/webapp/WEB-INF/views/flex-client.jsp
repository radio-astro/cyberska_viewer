<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.File" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="shortcut icon" href="<spring:theme code="favicon.path" text="/favicon.ico"/>"/>
<link rel="stylesheet" type="text/css" href="/themes/pureweb/pureweb.css"/>
<title><spring:theme code="client.title" text=""/></title>

<script type="text/javascript">
        window.pageLoadStartTime = (new Date()).getTime();
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<script type="text/javascript" src="/swfobject.js"></script>
<script type="text/javascript" src="/lib/jquery/jquery-1.4.2.min.js"></script>

<%@ page import="org.springframework.web.servlet.support.JspAwareRequestContext" %>

<!--
(AWS): prototype.js was causing a memory leak due to some weird interaction
       between the use of ExternalInterface in flex/flash.-->
<!-- script type="text/javascript" src="/prototype.js"/ -->

<script type="text/javascript" src="/pureweb.js"></script>
<script type="text/javascript" src="/bandwidth.js"></script>
<script type="text/javascript" src="/flex-bridge.js"></script>

<script type="text/javascript">
    window.onbeforeunload = function(e) {
        if (onBeforeUnloadApp.warningOnNavigatingAway){
            return onBeforeUnloadApp.warningOnNavigatingAwayMessage;
        }
    }

    // The onunload handler will disconect-client, if this fails the server will diconnect 
    // the client after the client-activity-timeout (about 30s - which is configurable)
    // 
    // WebClient will handle the call to disconnectClient, triggering disconnectSession in flex-client.jsp, resulting in a deletion
    // at the browser level.
    window.onunload = function(e){
        if (onUnloadApp.useJavascriptCleanup) {
            disconnectClient();
        }
    }
</script>

<style type="text/css">

body, html
{
    margin: 0;
    padding: 0;
    height: 100%;
    width: 100%;
    overflow: hidden;
}
</style>

<c:set var="customStyleSWF">
    <spring:theme code="style.swf" text=""/>
</c:set>

<c:set var="logoname">
     <spring:theme code="product.logo" text="/themes/pureweb/pureweb_serverpagelogo.png"/>
</c:set>

<c:set var="customURLPath">
    <spring:theme code="url.path" text="resmd"/>    
</c:set>

<c:set var="swfPath">
    <spring:theme code="swfPath" text=""/>    
</c:set>

<c:set var="productName">
    <spring:theme code="product.name" text=""/>
</c:set>

<c:set var="studybrowserLogo">
    <spring:theme code="studybrowser.logo" text=""/>
</c:set>

<c:set var="applicationsDescription">
    <spring:theme code="applications.Description" text=""/>
</c:set>

</head>
<body>

    <div id="appcontainer">
        <img src='${logoname}'/>
        <div style='padding-left:50px;padding-top:20px'>
            This application requires <a href="http://www.adobe.com/go/EN_US-H-GET-FLASH">Adobe Flash Player</a> version 10.2.152 or higher.
        </div>
    </div>

    <%
       String app = request.getParameter("app");

       // If launched via a Spring Controller, the 'app' will be in a request attribute
       if (app == null)
           app = (String)request.getAttribute("app");

       String swf = app;
       // JspAwareRequestContext provides access to the locale resolved by the locale
       // resolver used by the DispatcherServlet.
       String acceptLanguage = (new JspAwareRequestContext(pageContext)).getLocale().toString();
       
       pageContext.setAttribute("swf", swf);
       // ensure that the swf is not cached longer than it should be
       File file = new File(request.getSession().getServletContext().getRealPath(swf));
       pageContext.setAttribute("timestamp", file.lastModified());
       pageContext.setAttribute("acceptLanguage", acceptLanguage);
    %>

    <script type="text/javascript">
        document.title = "${productName}";
        
        var playerVersion = deconcept.SWFObjectUtil.getPlayerVersion();
        var pv_major = playerVersion.major;
        var pv_minor = playerVersion.minor;
        var pv_release = playerVersion.rev;

        if ((pv_major > 10) || (pv_major==10 && pv_minor > 2)  || (pv_major==10 && pv_minor >= 2 && pv_release >= 152))
        {
            var so = new SWFObject("${swfPath}/${swf}?timestamp=${timestamp}", "swfApp", "100%", "100%", "10.2.152", "#000000");
            so.useExpressInstall('expressinstall.swf');
            so.addParam("hasPriority", "true");
            so.addParam("quality", "high");
            so.addParam("name", "swfApp");
            so.addParam("id", "swfApp");
            so.addParam("AllowScriptAccess", "always");
            so.addParam("wmode", "window");
            so.addVariable("socketPolicyPort", "${applicationScope.socketPolicyPort}");
            so.addVariable("socketPolicyTimeout", "${applicationScope.socketPolicyTimeout}");
            so.addVariable("acceptLanguage", "${acceptLanguage}");
            so.addVariable("customStyleSWF", "${customStyleSWF}")
            so.addVariable("customURLPath", "${customURLPath}");
            so.addVariable("productName", "${productName}");
            so.addVariable("studybrowserLogo", "${studybrowserLogo}");
            so.addVariable("applicationsDescription", "${applicationsDescription}");
            so.write("appcontainer");
            
           window.document.swfApp.focus();
        }

        var propertyListeners = new Object();

        // Send a command to the remote application via the PureWeb client.
        // @param name:String the name of the command
        // @param ... variable number of parameters for the command; 
        //            for example:
        //               sendCommand("SetProperty", "/SomePropertyName", "value")
        function sendCommand(name) {
            var params = Array.prototype.slice.call(arguments);
            params.shift();
            document.swfApp.sendCommand(name, params);
        }

        function disconnectClient() {
            document.swfApp.disconnect();
        }
           
        // Sets the value of a property.
        // @param name:String the name of a property
        // @param value:String the new value of the property
        function setProperty(name, value) {
            document.swfApp.setProperty(name, value);
        }

        // Registers a property listener function with the PureWeb client so that the 
        // listener receives notification of property changes.
        // @param propertyName name of property to receive change notifications for
        // @param listenerFunction a callback with signature 'callback(propertyName, propertyValue)'
        function addPropertyChangeListener(propertyName, listenerFunction) {
            propertyListeners[propertyName] = listenerFunction;
            document.swfApp.addPropertyChangeListener("onPropertyChange", propertyName);
        }

        // Removes a property listener from receiving property change notifications
        // @param propertyName name of property to stop receiving change notifications for
        function removePropertyChangeListener(propertyName) {
            document.swfApp.removePropertyChangeListener("onPropertyChange", propertyName);
            propertyListeners[propertyName] = null;
        }

        // private function to facilitate property notifications from the PureWeb client
        function onPropertyChange(propertyName, propertyValue) {
            var listener = propertyListeners[propertyName];
            if (listener != null) {
                listener(propertyName, propertyValue);
            }
        }
    </script>

</body>
</html>
