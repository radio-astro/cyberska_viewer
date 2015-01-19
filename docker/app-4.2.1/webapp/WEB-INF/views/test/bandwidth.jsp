<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<t:master>
<jsp:attribute name="pagetitle"><spring:theme code="product.name"/>PureWeb Network Diagnostics</jsp:attribute>

<jsp:body>
<style type="text/css">
    a {color:black}
    table {color:black;background-color:gray}
    th {text-align:center}
    .button {background-color:slategray}
    .center {text-align:center}
    .underline {text-decoration: underline}
</style>
<div style='padding-left:55px;padding-top:20px'>
<h1>PureWeb Network Diagnostics</h1>
</div>

<div id="simple">
<table>
<tr>
<td style='width: 200px' onclick="show1('simple', false);show1('advanced', true);"><table>
<tr><td ><img id='graphicImage' src="/themes/pureweb/bw-init.png" width=50 height=50/></td>
<td><div id='graphicText'>PERFORMANCE</div></td></tr>
</table></td>
<td style='width: 300px' onclick="show1('simple', false);show1('advanced', true);">
    <table>
    <tr><td align="right">PureWeb Latency : </td><td><div id="divLatency" /></td></tr>
    <tr><td align="right">PureWeb Bandwidth : </td><td><div id="divBandwidth" /></td></tr>
    </table>
</td>
<td style='width:80px' align="center">
<input class='button' type="button" value="TEST" style='height:50px;width=50px' onclick="testSimple()" />
</td>
</tr>
</table>
</div>

<div id="advanced" style="display:none">
<table>

<tr>
<th style='width:200px'>Test</th>
<th>Parameters</th>
<th style='width:80px'><input class='button' type="button" value="Test All" onclick="testSimple()" /></th>
<th style='width:300px'>Results (min/avg/max)</th></tr>
<tr>
<td>Pureweb Latency</td>
<td>
repeat : 
<input type="text" value="5" id="latRepeats" />
</td>
<td class='center'>
<input class='button' type="button" value="Test" onclick="testLatency()" />
</td>
<td><div id="divAdLatency" /></td>
</tr>

<tr>
<td>PureWeb Bandwidth</td>
<td>
<table>
<tr><td>repeat :</td><td><input type="text" value="5" id="bwRepeats" /></td></tr>
<tr><td>bytes :</td><td><input type="text" value="1000000" id="bwBytes" /></td></tr>
</table>
</td>
<td align="center" valign="top">
<input type="button" class="button" value="Test" onclick="testBandwidth()" />
</td>
<td><div id="divAdBandwidth" /></td>
</tr>

<tr><td class="center" colspan=4 >
<a href="#" onclick="show1('advanced', false);show1('simple', true);">Return to simple test</a>
</td></tr>
</table>
</div>

<script type="text/javascript" src="/prototype.js"></script>
<script type="text/javascript" src="/pureweb.js"></script>
<script type="text/javascript" src="/bandwidth.js"></script>
<script>

function testLatency(oncomplete) {
    var repeats = $("latRepeats").value;
    $("divLatency").update("Testing");
    $("divAdLatency").update("Testing");
    makeRequests("/pureweb/test/bandwidth/1", repeats, function(stats) {
        $("divLatency").update(stats.avg + " ms");
         var strLatency = stats.min + " / " + stats.avg + " / " + stats.max + " ms"
         $("divAdLatency").update(strLatency);  
         logMessage("latency = " + strLatency);
         if (oncomplete) oncomplete();
    });
}

function testBandwidth(oncomplete) {
    var repeats = $("bwRepeats").value;
    var bytes = $("bwBytes").value;
    $("divBandwidth").update("Testing");
    $("divAdBandwidth").update("Testing");
    makeRequests("/pureweb/test/bandwidth/0", repeats, function(latencyStats) { 
	    makeRequests("/pureweb/test/bandwidth/" + bytes, repeats, function(bandwidthStats) {
		    if (bandwidthStats.min < latencyStats.min) {
			    latencyStats.min = 0;
		    }
	        $("divBandwidth").update(mbps(bytes, bandwidthStats.avg - latencyStats.min) + " mbps");
	        var strLatency = latencyStats.min + " / " + latencyStats.avg + " / " + latencyStats.max + " ms"
	        var strBandwidth = mbps(bytes, bandwidthStats.max - latencyStats.min) + " / " + mbps(bytes, bandwidthStats.avg - latencyStats.min) + " / " + mbps(bytes, bandwidthStats.min - latencyStats.min) + " mbps"
	        $("divAdBandwidth").update(strBandwidth);
	        logMessage("bandwidth = " + strBandwidth + ", latency = " + strLatency);
	        if (oncomplete) oncomplete();
	    });
    }, bytes);
}

function updateMessage() {
    latency_ms = parseFloat($("divLatency").innerHTML);
    bandwidth_mps = parseFloat($("divBandwidth").innerHTML);
    
    if (latency_ms > 100 || bandwidth_mps < 1)
    {
        img_file = "/themes/pureweb/bw-fail.png";
        img_text = "Poor";
    } else if (latency_ms > 50 || bandwidth_mps < 5) {
        img_file = "/themes/pureweb/bw-warn.png";
        img_text = "Warn";
    } else {
        img_file = "/themes/pureweb/bw-good.png";
        img_text = "Good";
    }
    $("graphicImage").src= img_file;
    $("graphicText").update(img_text);
}

function testSimple() {
    runTests(testLatency, testBandwidth, updateMessage);
}

function show1(id, visible) {
    $(id).style.display = (visible == true ? "" : "none");
}

</script>

<img style="position:absolute;bottom:10px;right:10px" src="/CSMG-Logo.png"/>

</jsp:body>
</t:master>
