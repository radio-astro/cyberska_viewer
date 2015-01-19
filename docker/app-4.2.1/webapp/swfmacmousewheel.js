/**
 * SWFMacMouseWheel v1.0: Mac Mouse Wheel functionality in flash - http://blog.pixelbreaker.com/
 *
 * SWFMacMouseWheel is (c) 2006 Gabriel Bucknall and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Dependencies: 
 * SWFObject v2.0 - (c) 2006 Geoff Stearns.
 * http://blog.deconcept.com/swfobject/
 */
function SWFMacMouseWheel( swfObject )
{
	this.so = swfObject;
	var isMac = navigator.appVersion.toLowerCase().indexOf( "mac" ) != -1;
	var isFirefox = navigator.userAgent.toLowerCase().indexOf("firefox") !=-1;
	var isChrome = navigator.userAgent.toLowerCase().indexOf("chrome") != -1;
	if( isMac || isFirefox || isChrome) this.init();
}

SWFMacMouseWheel.prototype = {
	init: function()
	{
		SWFMacMouseWheel.instance = this;
		if (window.addEventListener)
		{
	        window.addEventListener('DOMMouseScroll', SWFMacMouseWheel.instance.wheel, false);
		}
		window.onmousewheel = document.onmousewheel = SWFMacMouseWheel.instance.wheel;
	},
	
	handle: function( event )
	{
		document[ this.so.getAttribute('id') ].externalMouseEvent( event );
	},

	wheel: function(event){
        var details = {delta:0, 
                       ctrlKey:event.ctrlKey, 
                       altKey:event.altKey, 
                       shiftKey:event.shiftKey};
        if (event.wheelDelta) { /* IE/Opera. */
			details.delta = event.wheelDelta/120;
			if (window.opera) details.delta = -details.delta;
        } else if (event.detail) { /** Mozilla case. */
            details.delta = -event.detail/3;
        }
        if( /AppleWebKit/.test(navigator.userAgent) ) {
        	details.delta /= 3;	
        }
        /** If delta is nonzero, handle it.
         * Basically, delta is now positive if wheel was scrolled up,
         * and negative, if wheel was scrolled down.
         */
        if (details.delta)
               SWFMacMouseWheel.instance.handle(details);
        /** Prevent default actions caused by mouse wheel.
         * That might be ugly, but we handle scrolls somehow
         * anyway, so don't bother here..
         */
        if (event.preventDefault) event.preventDefault();
		event.returnValue = false;
	}
};