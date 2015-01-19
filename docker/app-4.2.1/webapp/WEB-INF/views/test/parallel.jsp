<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/>PureWeb Parallel Request Test</jsp:attribute>

<jsp:body>

<div style="padding-left:55px;padding-top:20px">
<h1>PureWeb Parallel Request Test</h1>
</div>

<table style='color: black; background-color: gray'>

<tr>
<th style="width:125px;text-align:center;">Test</th>
<th style="text-align:center;">Parameters</th>
<th style="width:80px;text-align:center;"></th>
<th style="width:250px;text-align:center;">Results</th>
</tr>

<tr>
<td>Bandwidth</td>
<td>
<table>
<tr><td>requests :</td><td><input type="text" value="1" id="requests" /></td></tr>
<tr><td>bytes :</td><td><input type="text" value="135000" id="bytes" /></td></tr>
</table>
</td>
<td align="center" valign="top">
<input type="button" style="background-color:slategray" value="Test" onclick="testBandwidth()" />
</td>
<td valign="top"><div id="divBandwidth" /></td>
</tr>

</table>

<script type="text/javascript" src="/prototype.js"></script>
<script type="text/javascript" src="/pureweb.js"></script>
<script type="text/javascript" src="/bandwidth.js"></script>
<script>

function testBandwidth() { 
    var start = new Date();
    var requests_returned = 0;
    
    $("divBandwidth").update("Testing");
    
    var requests = $("requests").getValue();
    var bytes = $("bytes").getValue();
    var chunk = Math.round(bytes / requests);
       
    var makeRequest = function() {
        var xmlhttp = getXMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState==4) {
                if (xmlhttp.status==200) {
                    if (++requests_returned == requests)
                    {
                        var stop = new Date();
                        var dur = stop - start;
                        $("divBandwidth").update(dur.toString() + " ms @ " + mbps(bytes, dur) + " mbps");
                    }
                }
            }
        }
        xmlhttp.open("GET", "/pureweb/test/bandwidth/" + chunk + "?random=" + Math.floor(Math.random()*325125).toString(), true);
        xmlhttp.send();
    }
    
    for (i=0; i<requests; i++)
        makeRequest();
}

</script>

<img style="position:fixed;bottom:10px;right:10px" src="/themes/pureweb/CSMG-Logo.png"/>

</jsp:body>
</t:master>

