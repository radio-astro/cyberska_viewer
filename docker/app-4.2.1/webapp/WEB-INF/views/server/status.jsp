<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/> Server Status Page</jsp:attribute>
<jsp:body>
<c:set var="cluster" value="${applicationScope['pureweb.cluster.Cluster']}" />
<c:set var="request" value="${pageContext['request']}"/>

<jsp:useBean id="now" class="java.util.Date" />


<div class="node">
<h3>Cluster Status as of <f:formatDate value="${now}" type="both"/></h3>
<table>
<tbody>
<tr>
<c:forEach var="entry" items="${cluster.entries}">
    <c:forEach var="display" items="${entry.status.displays}">
        <c:forEach var="process" items="${display.processes}">
            <c:if test="${process.busy}">
                <td bgcolor="red" style="width: 4px; height: 7px"></td>
            </c:if>
        </c:forEach>
    </c:forEach>
</c:forEach>
<c:forEach var="entry" items="${cluster.entries}">
    <c:forEach var="display" items="${entry.status.displays}">
        <c:forEach var="process" items="${display.processes}">
            <c:if test="${process.idle}">
                <td bgcolor="green" style="width: 4px; height: 7px"></td>
            </c:if>
        </c:forEach>
    </c:forEach>
</c:forEach>
</tr>
</tbody>
</table>
</div>

<c:forEach var="entry" items="${cluster.entries}">
<c:choose>
<c:when test='${entry.status.hostname == cluster.node.hostname}'>
<div class="node activenode">
</c:when>
<c:otherwise>
<div class="node">
</c:otherwise>
</c:choose>
Node: <a href="${request.scheme}://${entry.status.hostname}:${request.serverPort}/pureweb/server/status">${entry.status.hostname}</a>
            ${cluster.node.driverInfo}
            (load ${entry.status.busyProcessCount}/${entry.status.totalProcessCount})
            <c:if test="${!entry.valid}"><span class="warning">(not responding)</span></c:if>
            <c:if test="${entry.status.clustered}">
                <a href="#" onclick="javascript:httpPutAndReload('/pureweb/cluster/${entry.status.hostname}/clustered', 'false')">
                    Clustered
                </a>
            </c:if>
            <c:if test="${!entry.status.clustered}">
                <a class="warning" href="#" onclick="javascript:httpPutAndReload('/pureweb/cluster/${entry.status.hostname}/clustered', 'true')">
                    Unclustered
                </a>
            </c:if>
            <c:if test="${entry.status.active}">
                <a href="#" onclick="javascript:httpPutAndReload('/pureweb/cluster/${entry.status.hostname}/active', 'false')">
                    Active
                </a>
            </c:if>
            <c:if test="${!entry.status.active}">
                <a class="warning" href="#" onclick="javascript:httpPutAndReload('/pureweb/cluster/${entry.status.hostname}/active', 'true')">
                    Inactive
                </a>
            </c:if>
        <c:forEach var="display" items="${entry.status.displays}">
            <div class="indent">
                Display: ${display.name} ${display.gpuInfo} ${display.gpuRam} (load ${display.busyProcessCount}/${display.totalProcessCount})
                <c:forEach var="process" items="${display.processes}">
                    <div class="indent">
                        Session:&nbsp;#${process.index}&nbsp;${process.name}&nbsp;${process.pid}&nbsp;${process.owner.sessionId}
                        <c:if test="${process.busy}">
                            <a href="#" onclick="javascript:httpDeleteAndReload('/pureweb/cluster/${entry.status.hostname}/${display.name}/${process.index}')">
                                Release
                            </a>
                            <c:forEach var="connection" items="${process.connections}">
                                <div class="indent">
                                    Connection: ${connection.owner.user}@${connection.owner.address} connected since <f:formatDate value="${connection.connectionDate}" type="both"/>
                                    <a style="padding-left:20px" href="#" onclick="javascript:httpDeleteAndReload('/pureweb/cluster/${entry.status.hostname}/${display.name}/${process.index}/${process.pid}/${connection.id}')">
                                        Disconnect
                                    </a>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>
</c:forEach>
<p/>
<div class="node activenode">
Queued Unmanaged Applications:
    <c:forEach var="unmanagedApp" items="${unmanagedApps}">
        <div class="indent">
            <c:choose>
            <c:when test='${unmanagedApp.hasHtml5Client}'>
                ${unmanagedApp.appName}
                <a href="${request.scheme}://${request.serverName}:${request.serverPort}/pureweb/app?name=${unmanagedApp.appName}&amp;client=html5&amp;appId=${unmanagedApp.appId}">
                    ${unmanagedApp.appId}
                </a> 
                connected at: <f:formatDate value="${unmanagedApp.connectedAt}" type="both"/>                
            </c:when>
            <c:otherwise>
                ${unmanagedApp.appName} ${unmanagedApp.appId} connected at: <f:formatDate value="${unmanagedApp.connectedAt}" type="both"/> 
            </c:otherwise>
            </c:choose>
            <a href="#" onclick="javascript:httpDeleteAndReload('/pureweb/cluster/unmanagedapp/${unmanagedApp.appId}')">
                Disconnect
            </a>
        </div>
    </c:forEach>
</div>
      
</jsp:body>
</t:master>
