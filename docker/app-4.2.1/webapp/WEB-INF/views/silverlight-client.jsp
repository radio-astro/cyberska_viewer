<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.File" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <script type="text/javascript" src="/prototype.js"></script>
        <script type="text/javascript" src="/pureweb.js"></script>
        <script type="text/javascript" src="/bandwidth.js"></script>

        <c:if test="${onunloadurl != null}">
        <script type="text/javascript">
            window.onunload = function(e) {
                httpGet("${onunloadurl}");
            }
        </script>
        </c:if>

        <link rel="stylesheet" type="text/css" href="/themes/pureweb/pureweb.css"/>
            <title>PureWeb</title>

            <script type="text/javascript"> window.pageLoadStartTime = (new Date()).getTime(); </script>

            <script type="text/javascript" src="/pureweb.js"></script>

            <style type="text/css">
                html, body {
                    height: 100%;
                    overflow: hidden; /* IE 8 shows always the scrollbar */
                }
                body {
                    padding: 0;
                    margin: 0;
                }
                #silverlightControlHost {
                    height: 100%;
                }
            </style>

            <!-- Silverlight App Scriptable Methods -->
            <script type="text/javascript" src="/silverlight-bridge.js"></script>

            <script type="text/javascript" src="/Silverlight.js"></script>

            <script type="text/javascript">
                function onSilverlightError(sender, args) {

                    var appSource = "";
                    if (sender != null && sender != 0) {
                        appSource = sender.getHost().Source;
                    }
                    var errorType = args.ErrorType;
                    var iErrorCode = args.ErrorCode;

                    var errMsg = "Unhandled Error in Silverlight 2 Application " +  appSource + "\n" ;

                    errMsg += "Code: "+ iErrorCode + "    \n";
                    errMsg += "Category: " + errorType + "       \n";
                    errMsg += "Message: " + args.ErrorMessage + "     \n";

                    if (errorType == "ParserError")
                    {
                        errMsg += "File: " + args.xamlFile + "     \n";
                        errMsg += "Line: " + args.lineNumber + "     \n";
                        errMsg += "Position: " + args.charPosition + "     \n";
                    }
                    else if (errorType == "RuntimeError")
                    {
                        if (args.lineNumber != 0)
                        {
                            errMsg += "Line: " + args.lineNumber + "     \n";
                            errMsg += "Position: " +  args.charPosition + "     \n";
                        }
                        errMsg += "MethodName: " + args.methodName + "     \n";
                    }

                    throw new Error(errMsg);
                }
            </script>

            <script type="text/javascript">

                function IsChild()
                {
                    return (window.opener != null && !window.opener.closed);
                }

                <!-- Note: childWindow variable is eval'd in the Silverlight app, only by certain browsers -->
                function HasChild()
                {
                    return (window.childWindow != null);
                }

                function CloseChild()
                {
                    if (HasChild())
                    {
                        window.childWindow.CloseWindow();
                    }
                }

                function CloseWindow()
                {
                    self.close();
                }

                function ChildClosed()
                {
                    window.childWindow = null;
                    var control = document.getElementById("silverlightControl");
                    control.Content.Framework.ChildClosed();
                }

                function PingServer()
                {
                    var control = document.getElementById("silverlightControl");
                    control.Content.Framework.PingServer();
                }

                function Tickle()
                {
                    if (HasChild())
                    {
                        window.childWindow.PingServer();
                    }
                    else if (IsChild())
                    {
                        window.opener.PingServer();
                    }
                }

                /** Focus the silverlight control. Seems to only work in Firefox and IE.
                 *  Chrome and Safari still require the user to click on the Silverlight app before
                 *  being able to interact with it.
                 */
                function FocusSilverlightControl()
                {
                    var control = document.getElementById("silverlightControl");
                    control.focus();
                }

                document.observe("dom:loaded", FocusSilverlightControl);

            </script>

    </head>

    <body>

        <%
            String app = request.getParameter("app");

            // If launched via a Spring Controller, the 'app' will be in a request attribute
            if (app == null)
                app = (String)request.getAttribute("app");

            String xap = app;

			if (!xap.endsWith(".xap")) {
				xap = xap + ".xap";
			}
			
            String acceptLanguage = request.getHeader("Accept-Language");

            if (acceptLanguage!= null && acceptLanguage.length () > 0) {
                acceptLanguage = acceptLanguage.replace(',', ':');
            }

            pageContext.setAttribute("xap", xap);

            File file = new File(request.getSession().getServletContext().getRealPath(xap));
            pageContext.setAttribute("timestamp", file.lastModified());
            pageContext.setAttribute("acceptLanguage", acceptLanguage);
        %>

        <!-- Runtime errors from Silverlight will be displayed here.
	         This will contain debugging information and should be removed or hidden when debugging is completed -->
        <div id='errorLocation' style="font-size: small;color: Gray;"></div>

        <div id="silverlightControlHost">
            <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="100%" id="silverlightControl">
                <param name="source" value="/${xap}?timestamp=${timestamp}" />
                <param name="onerror" value="onSilverlightError" />
                <param name="background" value="white" />
                <param name="minRuntimeVersion" value="<spring:theme code="silverlight.min.version"/>" />
                <param name="autoUpgrade" value="true" />
                <param name="windowless" value="true" />
                <param name="initParams" value="acceptLanguage=${acceptLanguage}"/>
                <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=<spring:theme code="silverlight.min.version"/>" style="text-decoration: none;">
                    <img src="/images/InstallSilverlight.png" alt="Get Microsoft Silverlight" style="border-style: none"/>
                </a>
            </object>
            <iframe style='visibility:hidden;height:0;width:0;border:0px'></iframe>
        </div>
    </body>
</html>
