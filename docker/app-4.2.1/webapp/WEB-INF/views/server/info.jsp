<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
URL docInfoUrl = pageContext.getServletContext().getResource("/WEB-INF/views/server/doc-info.txt");
if (docInfoUrl != null) {
    InputStream inStream = docInfoUrl.openStream();
    ByteArrayOutputStream outStream = new ByteArrayOutputStream();
    int b = 0;
    while ((b = inStream.read()) != -1) {
        outStream.write((byte)b);
    }
    request.setAttribute("docInfo", outStream.toString("UTF-8"));
} else {
    request.setAttribute("docInfo", "");
}
%>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Version Information</jsp:attribute>
<jsp:body>
<h2 class="highlight"><spring:theme code="product.name"/> Version Information</h2>

<pre><c:out value="${info}"/> <jsp:include page="/WEB-INF/views/server/doc-info.txt" flush="true"/></pre>

</jsp:body>
</t:master>
