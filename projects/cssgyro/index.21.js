const workingEventTypes = {
  DeviceOrientationEvent: false,
};

function setGolbalCSSNumber(name, value) {
  document.documentElement.style.setProperty(
    `--${name}`,
    +value || 0
  );
}

function handleDeviceOrientation(event) {
  event || (event = {});
  workingEventTypes.DeviceOrientationEvent = true;

  setGolbalCSSNumber("gyro--z", event.alpha);
  setGolbalCSSNumber("gyro--x", event.beta);
  setGolbalCSSNumber("gyro--y", event.gamma);
}

function tryToAddOrientationEventListener() {
  if (workingEventTypes.DeviceOrientationEvent) { return; }  window.addEventListener("deviceorientation", handleDeviceOrientation);
}

tryToAddOrientationEventListener();
// for iOS permissions
prepareMotionAccessRequest("DeviceOrientationEvent");
