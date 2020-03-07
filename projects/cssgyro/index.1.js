
    function setGolbalCSSNumber(name, value) {
      document.documentElement.style.setProperty(
        `--${name}`,
        Math.round(+value || 0)
      );
    }

    function handleOrientationChange(event = {}) {
      setGolbalCSSNumber("rotation--angle", screen.orientation.angle);
    }

    if (!window.DeviceOrientationEvent) {
      //alert("Your browser doesn’t support orientation events");
    }
    function handleDeviceOrientation(event = {}) {
      setGolbalCSSNumber("gyro--absolute", event.absolute);
      setGolbalCSSNumber("gyro--z", event.alpha);
      setGolbalCSSNumber("gyro--x", event.beta);
      setGolbalCSSNumber("gyro--y", event.gamma);

      setGolbalCSSNumber("compass--heading", event.compassHeading || event.webkitCompassHeading);
      setGolbalCSSNumber("compass--accuracy", event.compassAccuracy || event.webkitCompassAccuracy);
    }

    if (!window.DeviceMotionEvent) {
      //alert("Your browser doesn’t support motion events");
    }
    function handleDeviceMotion(event = {}) {
      setGolbalCSSNumber("motion--acceleration-x", event.acceleration?.x * 20);
      setGolbalCSSNumber("motion--acceleration-y", event.acceleration?.y * 20);
      setGolbalCSSNumber("motion--acceleration-z", event.acceleration?.z * 20);

      setGolbalCSSNumber("motion--acceleration-including-gravity-x", event.accelerationIncludingGravity?.x * 20);
      setGolbalCSSNumber("motion--acceleration-including-gravity-y", event.accelerationIncludingGravity?.y * 20);
      setGolbalCSSNumber("motion--acceleration-including-gravity-z", event.accelerationIncludingGravity?.z * 20);

      setGolbalCSSNumber("motion--rotation-rate-z", event.rotationRate?.alpha);
      setGolbalCSSNumber("motion--rotation-rate-x", event.rotationRate?.beta);
      setGolbalCSSNumber("motion--rotation-rate-y", event.rotationRate?.gamma);

      setGolbalCSSNumber("motion--interval", event.interval * 20);
    }

    handleOrientationChange();
    handleDeviceOrientation();
    handleDeviceMotion();

    window.addEventListener("orientationchange", handleOrientationChange, true);
    window.addEventListener("deviceorientation", handleDeviceOrientation, true);
    window.addEventListener("devicemotion", handleDeviceMotion, true);
