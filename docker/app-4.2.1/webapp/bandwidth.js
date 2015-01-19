
function arrayStats(array) {
    var stats = new Object();
    var sum;
    
    stats.min = stats.max = sum = array[0];
    for (i = 1; i < array.length; i++) {
        if (array[i] > stats.max) {
            stats.max = array[i];
        }
        if (array[i] < stats.min) {
            stats.min = array[i];
        }
        sum += array[i];
    }
    stats.avg = Math.round(100 * sum / array.length) / 100.0;
    return stats;
}

function makeRequests(url, count, oncomplete){
    var latencies = new Array();
    var makeRequest = function() {
        start = new Date();
        var xmlhttp = getXMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState==4) {
                if (xmlhttp.status==200) {
                    var stop = new Date();
                    latencies[latencies.length] = stop - start;            
                    if (latencies.length < count) {
                       makeRequest();
                    } else {
                        oncomplete(arrayStats(latencies));
                    }
                }
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }
    makeRequest();
}

function logMessage(message) {
    var xmlhttp = getXMLHttpRequest();
    xmlhttp.open("POST", "/pureweb/test/log", false);
    xmlhttp.send(message);
}

function mbps(bytes, ms) {
    return Math.round(bytes * 8 / 1024 / 1024 * 1500 / 1480 / (ms / 1000) * 100) / 100.0;
}

function runTests()
{
    function runTestArray(tests) {
        if (tests.length > 0) { 
            var test = tests.shift();
            test( function(){runTestArray(tests);} );
        }
    }    
    runTestArray(Array.prototype.slice.call(arguments));    
}

function testSimple()
{
    runTests(testLatency, testBandwidth, updateMessage);
}

