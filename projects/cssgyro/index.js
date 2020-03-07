alert(8);

if (!window.DeviceOrientationEvent) {
  alert("Your browser doesn’t support orientation events");
}
window.addEventListener("deviceorientation", handleOrientationChange, true);
function handleOrientationChange(event) {
  alert("deviceorientation");
  let cssText = `
    --gyro--absolute: ${event.absolute};
    --gyro--alpha: ${event.alpha};
    --gyro--beta: ${event.beta};
    --gyro--gamma: ${event.gamma};
  `;
  console.log(cssText);
  document.documentElement.style.cssText = cssText;
}

if (!window.DeviceMotionEvent) {
  alert("Your browser doesn’t support motion events");
}
window.addEventListener("devicemotion", handleMotionChange, true);
function handleMotionChange(event) {
  alert("devicemotion");
  let cssText = `
    --motion--acceleration-x: ${event.acceleration.x || 0};
    --motion--acceleration-y: ${event.acceleration.y || 0};
    --motion--acceleration-z: ${event.acceleration.z || 0};

    --motion--accelerationIncludingGravity-x: ${event.accelerationIncludingGravity.x || 0};
    --motion--accelerationIncludingGravity-y: ${event.accelerationIncludingGravity.y || 0};
    --motion--accelerationIncludingGravity-z: ${event.accelerationIncludingGravity.z || 0};

    --motion--rotation-rate-alpha: ${event.rotation-rate.alpha || 0};
    --motion--rotation-rate-beta: ${event.rotation-rate.beta || 0};
    --motion--rotation-rate-gamma: ${event.rotation-rate.gamma || 0};

    --motion--interval: ${event.interval};
  `;
  console.log(cssText);
  document.documentElement.style.cssText = cssText;
}
