const workingEventTypes = {
  DeviceOrientationEvent: false,
  DeviceMotionEvent: false,
};

function setGolbalCSSNumber(name, value) {
  document.documentElement.style.setProperty(
    `--${name}`,
    +value || 0
  );
}

function handleOrientationChange(event) {
  event || (event = {});

  setGolbalCSSNumber(
    "rotation--angle",
    (
      (screen && screen.orientation)
        ? screen.orientation.angle // not iOS
        : window.orientation // iOS
    )
  );
}

function handleDeviceOrientation(event) {
  event || (event = {});
  workingEventTypes.DeviceOrientationEvent = true;

  setGolbalCSSNumber("gyro--absolute", event.absolute ? 0 : 180);
  setGolbalCSSNumber("gyro--z", event.alpha);
  setGolbalCSSNumber("gyro--x", event.beta);
  setGolbalCSSNumber("gyro--y", event.gamma);

  setGolbalCSSNumber("compass--heading", event.compassHeading || event.webkitCompassHeading);
  setGolbalCSSNumber("compass--accuracy", event.compassAccuracy || event.webkitCompassAccuracy);
}

function handleDeviceMotion(event) {
  event || (event = {});
  workingEventTypes.DeviceMotionEvent = true;

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
}

function tryToAddOrientationEventListener() {
  if (workingEventTypes.DeviceOrientationEvent) { return; }

  window.addEventListener("deviceorientation", handleDeviceOrientation);
}

function tryToAddMotionEventListener() {
  if (workingEventTypes.DeviceMotionEvent) { return; }

  window.addEventListener("devicemotion", handleDeviceMotion);
}

function prepareMotionAccessRequest(type) {
  let EventClass = window[type];
  if (!EventClass || typeof EventClass.requestPermission !== "function") { return; }

  document.body.addEventListener("touchend", async () => {
    if (workingEventTypes[type]) { return; }

    try {
      let permission = EventClass.requestPermission();
      if (permission === "granted") {
        tryToAddOrientationEventListener();
      } else {
        document.body.innerHTML = "<h1>Sorry, you denied required permissions, this won’t work. ☹️</h1>";
      }
    } catch (error) {
      prompt("Something went wrong with permissions", error);
    }
  }, { once: true });
}

window.addEventListener("orientationchange", handleOrientationChange);

tryToAddOrientationEventListener();
tryToAddMotionEventListener();

// iOS needs permissions to add the events
prepareMotionAccessRequest("DeviceOrientationEvent");
prepareMotionAccessRequest("DeviceMotionEvent");
