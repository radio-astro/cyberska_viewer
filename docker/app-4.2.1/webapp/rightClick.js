/**
 *
 * Copyright 2007
 *
 * Paulius Uza
 * http://www.uza.lt
 *
 * Dan Florio
 * http://www.polygeek.com
 *
 * Project website:
 * http://code.google.com/p/custom-context-menu/
 *
 * --
 * RightClick for Flash Player.
 * Version 0.6.2
 *
 */
var rightDown = false;
var RightClick = {
    /**
     *  Constructor
     */
    init: function (flashContainerID, flashObjectID) {
        this.FlashObjectID = flashObjectID;
        this.FlashContainerID = flashContainerID;
        document.getElementById(this.FlashObjectID).focus();
        this.Cache = this.FlashObjectID;
        if(window.addEventListener){
            window.addEventListener("mousedown", this.onGeckoMouse(), true);
            window.addEventListener("mouseup", this.onGeckoMouseUp(), true);
        } else {
            document.getElementById(this.FlashContainerID).onmouseup = function() { document.getElementById(RightClick.FlashContainerID).releaseCapture(); RightClick.onIEMouseUp();}
            document.oncontextmenu = function(){ if(window.event.srcElement.id == RightClick.FlashObjectID) { return false; } else { RightClick.Cache = "nan"; }}
            document.getElementById(this.FlashContainerID).onmousedown = RightClick.onIEMouse;
        }
    },

    /**
     * GECKO / WEBKIT event overkill
     * @param {Object} eventObject
     */
    killEvents: function(eventObject) {
        if(eventObject) {
            if (eventObject.stopPropagation) eventObject.stopPropagation();
            if (eventObject.preventDefault) eventObject.preventDefault();
            if (eventObject.preventCapture) eventObject.preventCapture();
            if (eventObject.preventBubble) eventObject.preventBubble();
        }
    },
    /**
     * GECKO / WEBKIT call right click
     * @param {Object} ev
     */
    onGeckoMouse: function(ev) {
        return function(ev) {
            if (ev.button == 2) {
                RightClick.killEvents(ev);
                if(ev.target.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
                    RightClick.buttonDown();
                }
                RightClick.Cache = ev.target.id;
            }
        }
    },

    onGeckoMouseUp: function(ev) {
        return function(ev) {
            RightClick.buttonUp();
        }
    },

    /**
     * IE call right click
     * @param {Object} ev
     */
    onIEMouse: function() {
        if (event.button == 2) {
            if(window.event.srcElement.id == RightClick.FlashObjectID && RightClick.Cache == RightClick.FlashObjectID) {
                RightClick.buttonDown();
            }
            document.getElementById(RightClick.FlashContainerID).setCapture();
            if(window.event.srcElement.id)
                RightClick.Cache = window.event.srcElement.id;
        }
    },

    onIEMouseUp: function() {
        RightClick.buttonUp();
    },

    /**
     * Main call to Flash External Interface
     */
    buttonDown: function() {
        rightDown = true;
        document.getElementById(this.FlashObjectID).rightMouseDown();
    },

    buttonUp: function() {
        if (rightDown) {
            document.getElementById(this.FlashObjectID).rightMouseUp();
            rightDown = false;
        }
    }
}


// Detect if the browser is IE or not.
// If it is not IE, we assume that the browser is NS.
var IE = document.all?true:false;

// If NS -- that is, !IE -- then set up for mouse capture
if (!IE) document.captureEvents(Event.MOUSEMOVE)

// Set-up to use getMouseXY function onMouseMove
document.onmousemove = getMouseXY;

// Main function to retrieve mouse x-y pos.s
function getMouseXY(e) {
    var posx = 0;
    var posy = 0;
    if (!e) var e = window.event;
    if (e.pageX || e.pageY) 	{
        posx = e.pageX;
        posy = e.pageY;
    }
    else if (e.clientX || e.clientY) 	{
        posx = e.clientX + document.body.scrollLeft
            + document.documentElement.scrollLeft;
        posy = e.clientY + document.body.scrollTop
            + document.documentElement.scrollTop;
    }
    else {
        return;
    }

    // catch possible negative values in NS4
    if (posx < 0){posx = 0}
    if (posy < 0){posy = 0}


    if (rightDown && IE) {
        document.getElementById(RightClick.FlashObjectID).rightMouseMove(posx,posy);
    }

    return true;
}
