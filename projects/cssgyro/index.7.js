try {

  function setGolbalCSSNumber(name, value) {
    document.documentElement.style.setProperty(
      `--${name}`,
      Math.round(+value || 0)
    );
  }

  function handleOrientationChange(event) {event || (event = {});
    setGolbalCSSNumber("rotation--angle", (screen.orientation && screen.orientation.angle));

    alert("handleOrientationChange");
  }

  function handleDeviceOrientation(event) {event || (event = {});
    setGolbalCSSNumber("gyro--absolute", event.absolute);
    setGolbalCSSNumber("gyro--z", event.alpha);
    setGolbalCSSNumber("gyro--x", event.beta);
    setGolbalCSSNumber("gyro--y", event.gamma);

    setGolbalCSSNumber("compass--heading", event.compassHeading || event.webkitCompassHeading);
    setGolbalCSSNumber("compass--accuracy", event.compassAccuracy || event.webkitCompassAccuracy);

    alert("handleDeviceOrientation");
  }

  function handleDeviceMotion(event) {event || (event = {});
    setGolbalCSSNumber("motion--acceleration-x", (event.acceleration && event.acceleration.x) * 20);
    setGolbalCSSNumber("motion--acceleration-y", (event.acceleration && event.acceleration.y) * 20);
    setGolbalCSSNumber("motion--acceleration-z", (event.acceleration && event.acceleration.z) * 20);

    setGolbalCSSNumber("motion--acceleration-including-gravity-x", (event.accelerationIncludingGravity && event.accelerationIncludingGravity.x) * 20);
    setGolbalCSSNumber("motion--acceleration-including-gravity-y", (event.accelerationIncludingGravity && event.accelerationIncludingGravity.y) * 20);
    setGolbalCSSNumber("motion--acceleration-including-gravity-z", (event.accelerationIncludingGravity && event.accelerationIncludingGravity.z) * 20);

    setGolbalCSSNumber("motion--rotation-rate-z", (event.rotationRate && event.rotationRate.alpha));
    setGolbalCSSNumber("motion--rotation-rate-x", (event.rotationRate && event.rotationRate.beta));
    setGolbalCSSNumber("motion--rotation-rate-y", (event.rotationRate && event.rotationRate.gamma));

    setGolbalCSSNumber("motion--interval", event.interval * 20);

    alert("handleDeviceMotion");
  }

  handleOrientationChange();
  handleDeviceOrientation();
  handleDeviceMotion();

  window.addEventListener("orientationchange", handleOrientationChange, true);
  window.addEventListener("deviceorientation", handleDeviceOrientation, true);
  window.addEventListener("devicemotion", handleDeviceMotion, true);

  alert("working");
} catch (error) {
  alert(error);
}
