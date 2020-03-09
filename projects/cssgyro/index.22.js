import { requestOrientationAPIPermission } from "./get-motion-permissions.js";
import { setGlobalCSSCustomProperty } from "./set-css-custom-property.js";

function handleDeviceOrientation(event) {
  setGlobalCSSCustomProperty("gyro--z", +event.alpha || 0);
  setGlobalCSSCustomProperty("gyro--x", +event.beta || 0);
  setGlobalCSSCustomProperty("gyro--y", +event.gamma || 0);
  console.log(event.alpha);
}

setGlobalCSSCustomProperty("gyro--z", 0);
setGlobalCSSCustomProperty("gyro--x", 0);
setGlobalCSSCustomProperty("gyro--y", 0);

requestOrientationAPIPermission()
  .then(grantedReason => {
    window.addEventListener("deviceorientation", handleDeviceOrientation);
  })
  .catch(deniedReason => {
    switch (deniedReason) {
      case "not supported":
        document.body.innerHTML = `
          <h2>Not supported</h2>
          <p>Sorry, Your browser doesn’t support this experiment</p>
          <p>This is mostly for mobile devices, although a few laptops support it too.</p>
        `;
        break;
      default:
        document.body.innerHTML = `
          <h2>Permissions required</h2>
          <p>Sorry, you’ve denied required permissions.</p>
          <p>You will need to quit and reopen your browser to continue</p>
        `;
        break;
    }
  });
