/*  silverlight-bridge.js
 *  
 *  These Javasctipt functions are script calls to the 
 *  Silverlight bridge and are used for automation and diagnostics
 *
 *--------------------------------------------------------------------------*/

// Call Login
function login(username, password)
{
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.Login(username, password);
}

// call Logout
function logout()
{
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.Logout();
}

// Perform a Query search based on the search criteria given below
//      PatientId,
//      PatientName,
//      PatientBirthdate,
//      StudyInstanceUid,
//      StudyTime,
//      ReferringPhysiciansName,
//      StudyDescription,
//      ModalitiesInStudy,
//      StudyDate,
// Note: Passing an empty string would result in search all
//       upto four search criteria can be supplied A maximum of
//       four criteria can be passed.
//
// Usage: searchParam =
//                   <parameters>
//                      <searchcriteria>
//                          <key>PatientName</key>
//                          <value>Mr. X</value>
//                      </searchcriteria>
//                       <searchcriteria>
//                           <key>ModalitiesInStudy</key>
//                           <value>CT</value>
//                       </searchcriteria>
//                   </parameters>
function queryView(searchParam)
{
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.QueryView(searchParam);
}

// Load a study with a specified patientName and StudyDateTime
function loadSelectedStudy(patientName, studyDateTime)
{
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.LoadSelectedStudy(patientName, studyDateTime);
}

// send a command
function sendCommand(commandName, params)
{
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.SendCommand(commandName, params);
}

// Changes the image-view-mode (Single2D, Single3D, MipMpr)
function changeViewMode(imageViewMode)
{
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.ChangeViewMode(imageViewMode);
}

// Latency Test Complete callback               
function onLatencyTestComplete_Callback(stats) 
{        
    var arg = "min:" + stats.min + ";max:" + stats.max + ";avg:" + stats.avg; 
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.OnLatencyTestComplete(arg);
} 
 
// Bandwidth Test complete
function onBandwidthTestComplete_Callback(stats) 
{        
    var arg = "min:" + stats.min + ";max:" + stats.max + ";avg:" + stats.avg; 
    var SLControl = document.getElementById("silverlightControl");
    SLControl.Content.Bridge.OnBandwidthTestComplete(arg);

} 
 
// Latency Test method
function doLatencyTest(iterations) 
{ 
    makeRequests("/pureweb/test/bandwidth/1", iterations, onLatencyTestComplete_Callback); 
} 

// Bandwidth Test method.
function doBandwidthTest(byteCount, iterations) 
{ 
    makeRequests("/pureweb/test/bandwidth/"+byteCount, iterations, onBandwidthTestComplete_Callback); 
}