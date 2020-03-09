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
        display: block;
        box-sizing: border-box;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        position: fixed;
        top: 50%;
        left: 50%;
        z-index: 99999999999;
        transform: translate(-50%, -50%);
        max-width: 90vw;
        min-width: 320px;
        border: none;
        background: white;
        font: inherit;
        box-shadow:
          inset -1vw -2vw 2vw rgba(0, 0, 0, 0.2),
          0 1vw 4vw rgba(0, 0, 0, 0.3)
        ;
        border-radius: 10vw;
        font-size: 8vmin;
        padding: 10vw;
        opacity: 0.9;
        line-height: 1.4;
      `;
      dialogueElement.innerHTML = `
        <span style="display: block; font-weight: 900">
          Click&nbsp;here to&nbsp;start
        </span>
        <span style="display: block; font-size: 0.7em; margin-top: 0.5em">
          You will be asked to give permission to see your phone’s rotation.
        </span>
        <span style="display: block; font-size: 0.5em; margin-top: 0.5em">
          This is a requirement by iOS.
          It lets me know how much you’ve turned your phone and how fast it’s moving.
        </span>
      `;
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
