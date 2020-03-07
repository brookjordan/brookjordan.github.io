let orientationEventWorking = false;
let motionEventWorking = false;

function setGolbalCSSNumber(name, value) {
  document.documentElement.style.setProperty(
    `--${name}`,
    +value || 0
  );
}

function handleOrientationChange(event) {event || (event = {});
  setGolbalCSSNumber(
    "rotation--angle",
    (
      (screen && screen.orientation)
        ? screen.orientation.angle
        : window.orientation
    )
  );
}

function handleDeviceOrientation(event) {event || (event = {});
  setGolbalCSSNumber("gyro--absolute", event.absolute);
  setGolbalCSSNumber("gyro--z", event.alpha);
  setGolbalCSSNumber("gyro--x", event.beta);
  setGolbalCSSNumber("gyro--y", event.gamma);

  setGolbalCSSNumber("compass--heading", event.compassHeading || event.webkitCompassHeading);
  setGolbalCSSNumber("compass--accuracy", event.compassAccuracy || event.webkitCompassAccuracy);

  orientationEventWorking = true;
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

  motionEventWorking = true;
}

function addOrientationEvent() {
  if (orientationEventWorking) { return; }
  window.addEventListener("deviceorientation", handleDeviceOrientation);
}

function addMotionEvent() {
  if (motionEventWorking) { return; }
  window.addEventListener("devicemotion", handleDeviceMotion);
}

function prepareOrientationAccessRequest() {
  document.body.addEventListener("touchend", () => {
    if (orientationEventWorking) { return; }

    DeviceOrientationEvent.requestPermission()
    .then(permission => {
      if (permission === "granted") {
        addOrientationEvent();
      } else {
        document.body.innerHTML = "<h1>Sorry, you denied required permissions, this won’t work. ☹️</h1>";
      }
    })
    .catch(error => {
      prompt("Something went wrong with permissions", error);
    });
  }, { once: true });
}

function prepareMotionAccessRequest() {
  document.body.addEventListener("touchend", () => {
    if (motionEventWorking) { return; }

    DeviceMotionEvent.requestPermission()
    .then(permission => {
      if (permission === "granted") {
        addMotionEvent();
      } else {
        document.body.innerHTML = "<h1>Sorry, you denied required permissions, this won’t work. ☹️</h1>";
      }
    })
    .catch(error => {
      prompt("Something went wrong with permissions", error);
    });
  }, { once: true });
}

window.addEventListener("orientationchange", handleOrientationChange);

addOrientationEvent();
if (window.DeviceOrientationEvent && typeof DeviceOrientationEvent.requestPermission === "function") {
  prepareOrientationAccessRequest();
}

addMotionEvent();
if (window.DeviceMotionEvent && typeof DeviceMotionEvent.requestPermission === "function") {
  prepareMotionAccessRequest();
}
