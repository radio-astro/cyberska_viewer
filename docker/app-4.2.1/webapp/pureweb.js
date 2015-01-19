// http://www.hunlock.com/blogs/Mastering_The_Back_Button_With_Javascript
// http://www.w3.org/TR/XMLHttpRequest

function getXMLHttpRequest() {
    if (window.XMLHttpRequest)
       return new XMLHttpRequest();
    if (window.ActiveXObject)
       return new ActiveXObject("Microsoft.XMLHTTP");
}

// basic http requests

function httpDelete(path) {
    var request = getXMLHttpRequest();
    request.onreadystatechange = function() { if (request.readyState != 4) return false; }
    request.open('DELETE', path, false);
    request.send(null);
}

function httpGet(path) {
    var request = getXMLHttpRequest();
    request.onreadystatechange = function() { if (request.readyState != 4) return false; }
    request.open('GET', path, false);
    request.send(null)
}

function httpPut(path, value) {
    var request = getXMLHttpRequest();
    request.onreadystatechange = function() { if (request.readyState != 4) return false; }
    request.open('PUT', path, false);
    request.send(value);
}

// http requests that also reload the current page to display updated information

function httpDeleteAndReload(path) {
    httpDelete(path);
    window.location.reload();
}

function httpPutAndReload(path, value) {
    httpPut(path, value);
    window.location.reload();
}

// This is a helper JavaScript literal variable and is used by clients
// to warn users when they accidentally attempt to navigate away by
// clicking back/forward/refresh/close buttons. 
// It is used in conjunction with "onbeforeunload" handler
var onBeforeUnloadApp = {
    // This flag indicates if there is going to be a prompt to warn
    warningOnNavigatingAway: true,
    
    warningOnNavigatingAwayMessage: "Refreshing or leaving this page will cause you \n " +
                                    "to lose the work you have done.\n\n",

    setWarningOnNavigatingAway: function (value) {
        onBeforeUnloadApp.warningOnNavigatingAway = value;
    },
    
    setWarningOnNavigatingAwayMessage: function (value){
        onBeforeUnloadApp.warningOnNavigatingAwayMessage = value;
    }
}

// This is a helper JavaScript literal variable and is used by clients
// to decide whether the app cleaned itself up or if we need to do it
// with JavaScript instead (due to page refresh, back button, etc)
var onUnloadApp = {
    useJavascriptCleanup: true,

    setUseJavascriptCleanup: function (value) {
        onUnloadApp.useJavascriptCleanup = value;
    }
}
