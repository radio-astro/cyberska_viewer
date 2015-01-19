/*
 *
 * Find more about this plugin by visiting
 * http://alxgbsn.co.uk/
 *
 * Copyright (c) 2010-2012 Alex Gibson
 * Released under MIT license
 *
 */

(function (window, document) {

    function Shake() {

        //feature detect
        this.hasDeviceMotion = 'ondevicemotion' in window;
        this.hasDeviceOrientation = 'orientation' in window;        

        //fallback?
        this.fallback = (this.hasDeviceOrientation && !this.hasDeviceMotion);
        
        //default velocity threshold for shake to register
        if (this.fallback){
            //threshold for orientation change is different than hasDeviceOrientation.
            this.threshold = 60;  
        }else{
            this.threshold = 10;                        
        }

        //use date to prevent multiple shakes firing
        this.lastTime = new Date();

        //accelerometer values
        this.lastX = null;
        this.lastY = null;
        this.lastZ = null;

        //create custom event
        if (typeof CustomEvent === "function") {
            this.event = new CustomEvent('shake', {
                bubbles: true,
                cancelable: true
            });
        } else if (typeof document.createEvent === "function") {
            this.event = document.createEvent('Event');
            this.event.initEvent('shake', true, true);
        } else { 
          return false;
        }
    }

    //reset timer values
    Shake.prototype.reset = function () {
        this.lastTime = new Date();
        this.lastX = null;
        this.lastY = null;
        this.lastZ = null;
    };

    //start listening for devicemotion / deviceorientation
    Shake.prototype.start = function () {
        this.reset();
        if (this.hasDeviceMotion) { 
            this.boundListener = this.deviceorientation.bind(this);
            window.addEventListener('devicemotion', this.boundListener, false); 
        }
        else if (this.hasDeviceOrientation) { 
            this.boundListener = this.deviceorientation.bind(this);
            window.addEventListener('deviceorientation', this.boundListener, false); 
        }
    };

    //stop listening for devicemotion / deviceorientation
    Shake.prototype.stop = function () {

        if (this.hasDeviceMotion) { 
            window.removeEventListener('devicemotion', this.boundListener, false); 
        }
        else if (this.hasDeviceOrientation) { 
            window.removeEventListener('deviceorientation', this.boundListener, false); 
        }
        this.reset();
    };    

    Shake.prototype.deviceorientation = function(e) {
    var currentTime,
        timeDifference,
        deltaX = 0,
        deltaY = 0,
        deltaZ = 0,
        x = 0,
        y = 0,
        z = 0;
        
        if (!this.fallback){
            //Use values from device motion
            x = e.accelerationIncludingGravity.x;
            y = e.accelerationIncludingGravity.y;
            z = e.accelerationIncludingGravity.z;
        }else{
            //Use values from device orientation
            x = e.gamma;
            y = e.beta;
            z = e.alpha;
        }
//     alert('MOTION: ' + x + ' ' + y ' ' + z + ' ' + e);

      if ((this.lastX === null) && (this.lastY === null) && (this.lastZ === null)) {
            this.lastX = x;
            this.lastY = y;
            this.lastZ = z;
            return;
      }

      //Determine the change
      deltaX = Math.abs(this.lastX - x);
      deltaY = Math.abs(this.lastY - y);
      deltaZ = Math.abs(this.lastZ - z);

//      alert('DELTA: ' + deltaX + ' ' + deltaY + ' ' + deltaZ);

      if (((deltaX > this.threshold) && (deltaY > this.threshold)) || ((deltaX > this.threshold) && (deltaZ > this.threshold)) || ((deltaY > this.threshold) && (deltaZ > this.threshold))) {
          //calculate time in milliseconds since last shake registered
          currentTime = new Date();
          timeDifference = currentTime.getTime() - this.lastTime.getTime();

          if (timeDifference > 1000) {
              window.dispatchEvent(this.event);
              this.lastTime = new Date();
          }
      }

      this.lastX = x;
      this.lastY = y;
      this.lastZ = z;
    };

    //event handler
    Shake.prototype.handleEvent = function (e) {

        if (typeof (this[e.type]) === 'function') {
            return this[e.type](e);
        }
    };

    //create a new instance of shake.js.
    var myShakeEvent = new Shake();
    myShakeEvent && myShakeEvent.start();

}(window, document));
