import { requestOrientationAPIPermission } from "./get-motion-permissions.js";
import { setGlobalCSSCustomProperty } from "./set-css-custom-property.js";

function handleDeviceOrientation(event) {
  setGlobalCSSCustomProperty("gyro--z", Math.round(event.alpha) || 0);
  setGlobalCSSCustomProperty("gyro--x", Math.round(event.beta) || 0);
  setGlobalCSSCustomProperty("gyro--y", Math.round(event.gamma) || 0);

  setGlobalCSSCustomProperty("gyro-int--z", Math.round(event.alpha) || 0);
  setGlobalCSSCustomProperty("gyro-int--x", Math.round(event.beta) || 0);
  setGlobalCSSCustomProperty("gyro-int--y", Math.round(event.gamma) || 0);
}

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
          <p>This mostly only works on modern mobile devices, although a few laptops support it too.</p>
        `;
        break;
      default:
        document.body.innerHTML = `
          <h2>Permissions required: ${deniedReason}</h2>
          <p>Sorry, you’ve denied required permissions.</p>
          <p>You will need to quit and reopen your browser to continue</p>
        `;
        break;
    }
  });
