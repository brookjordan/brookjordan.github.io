const PERMISSION_DEFINITIONS = [
  {
    EventClassName: "DeviceMotionEvent",
    eventName: "devicemotion",
  },

  {
    EventClassName: "DeviceOrientationEvent",
    eventName: "deviceorientation",
  },
];

const PERMISSIONS = {};
PERMISSION_DEFINITIONS.forEach((definition) => {
  if (definition.EventClassName in window) {
    PERMISSIONS[definition.eventName] = {
      state: null,
      EventClass: window[definition.EventClassName],
      eventName: definition.eventName,
    };
  }
});

let requestPromise;

function checkIfEventRuns(eventType) {
  let permissionDefinition = PERMISSIONS[eventType];
  let eventName = permissionDefinition.eventName;
  let promiseSettled = false;

  return new Promise((resolve, reject) => {
    window.addEventListener(eventName, () => {
      if (!promiseSettled) {
        resolve(true);
        promiseSettled = true;
      }
    }, { once: true });

    setTimeout(() => {
      if (!promiseSettled) {
        resolve(false);
        promiseSettled = true;
      }
    }, 300);
  });
}

async function resolveRequestPermissionWithTiming(resolve) {
  try {
    let reason = "previously";
    let reasonTimeout = requestAnimationFrame(() => { reason = "newly"; });
    let permission = await requestPromise;
    cancelAnimationFrame(reasonTimeout);
    resolve(`${permission}:${reason}`);
  } catch (error) {
    resolve(`denied:${error}`);
  }
}

function getEventPermission(eventType) {
  let permissionDefinition = PERMISSIONS[eventType];
  let EventClass = permissionDefinition.EventClass;

  return new Promise(async resolve => {
    if (requestPromise) {
      resolveRequestPermissionWithTiming(resolve);
    } else {
      let dialogueElement = document.createElement("button");
      dialogueElement.style.cssText = `
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        position: fixed;
        bottom: 10px;
        left: 50%;
        z-index: 99999999999;
        transform: translateX(-50%);
        max-width: 80vw;
        border: none;
        background: white;
        font: inherit;
        box-shadow: inset -2px -2px 2px rgba(0, 0, 0, 0.2), 0 1px 4px rgba(0, 0, 0, 0.3);
        border-radius: 5px;
        font-size: 22px;
        padding: 5px 10px;
      `;
      dialogueElement.textContent = "Click here to let me read your device’s orientation.";
      dialogueElement.addEventListener("touchend", async () => {
        requestPromise = EventClass.requestPermission();
        resolveRequestPermissionWithTiming(resolve);
        dialogueElement.remove();
      }, { once: true });
      document.body.appendChild(dialogueElement);
    }
  });
}

export default async function getMotionAPIPermission(eventType) {
  let permissionDefinition = PERMISSIONS[eventType];

  if (!permissionDefinition) {
    throw "not supported";
  }

  if (permissionDefinition.state !== null) {
    let [state, reason] = permissionDefinition.state.split(":");
    if (state === "granted") {
      return reason;
    } else {
      throw reason;
    }
  }

  let EventClass = permissionDefinition.EventClass;
  if (typeof EventClass.requestPermission !== "function") {
    permissionDefinition.state = "granted:not required";
    return "not required";
  }

  if (await checkIfEventRuns(eventType)) {
    permissionDefinition.state = "granted:previously";
    return "previously";
  }

  let [state, reason] = (await getEventPermission(eventType)).split(":");
  if (state === "granted") {
    return reason;
  } else {
    throw reason;
  }
}

export function requestOrientationAPIPermission() {
  return getMotionAPIPermission("deviceorientation")
}
