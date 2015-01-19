<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<t:master>

<jsp:attribute name="extrahead">
<script type="text/javascript">

</script>
</jsp:attribute>

<jsp:attribute name="pagetitle"><spring:theme code="product.name"/></jsp:attribute>

<jsp:body>
 <div>
     <h2>Unsupported client</h2>
     <p> We've detected you are attempting to join a collaborative session from a mobile device with no known client support. Please contact your administrator. </p>

 </div>
</jsp:body>
</t:master>
