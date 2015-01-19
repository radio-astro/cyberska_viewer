/*  flex-bridge.js
 *  
 *  These Javasctipt functions are script calls to the 
 *  Flex bridge and are used for diagnostics
 *
 *--------------------------------------------------------------------------*/


// Latency Test Complete callback
function onLatencyTestComplete_Callback(stats) 
{
    var arg = "min:" + stats.min + ";max:" + stats.max + ";avg:" + stats.avg;
    var flashObject;
    if (navigator.appName.indexOf("Microsoft") != -1) {
        flashObject = window["swfApp"];
    } else {
        flashObject = document["swfApp"];
    }
    flashObject.onLatencyComplete(arg);
} 
 
// Bandwidth Test complete callback
function onBandwidthTestComplete_Callback(stats) 
{
    var arg = "min:" + stats.min + ";max:" + stats.max + ";avg:" + stats.avg;
    var callback;
    if (navigator.appName.indexOf("Microsoft") != -1) {
        callback = window["swfApp"];
    } else {
        callback = document["swfApp"];
    }
    callback.onBandwidthComplete(arg);

} 
 
// Latency Test method
function doLatencyTest(url, iterations) 
{ 
    makeRequests(url, iterations, onLatencyTestComplete_Callback); 
} 

// Bandwidth Test method.
function doBandwidthTest(url, iterations) 
{ 
    makeRequests(url, iterations, onBandwidthTestComplete_Callback);
}

function disconnectSession(uri) 
{
    var pageHost = getHost(location.href);
    var uriHost = getHost(uri);
    var crossDomain = uriHost != pageHost;

    if(crossDomain) 
    {
        uri += "?_httpMethodOverride=DELETE";
        $.ajax({
            url: uri,
            dataType: "script"
        });
    } 
    else 
    {
        $.ajax({
            type: "DELETE",
            url: uri,
            async: false
        });
    }
}

function getHost(url) 
{
    var m = ((url||'')+'').match(/^http:\/\/([^/]+)/);
    return m ? m[1] : null;
}
