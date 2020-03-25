const connection = navigator.connection || navigator.mozConnection || navigator.webkitConnection;
const TYPES = [
  {
    name: "wifi",
    isExpensive: false,
  },
  {
    name: "unknown",
    isExpensive: true,
  },
  {
    name: "bluetooth",
    isExpensive: true,
  },
  {
    name: "cellular",
    isExpensive: true,
  },
  {
    name: "ethernet",
    isExpensive: false,
  },
  {
    name: "none",
    isExpensive: true,
  },
  {
    name: "wimax",
    isExpensive: false,
  },
  {
    name: "other",
    isExpensive: true,
  },
];
const EXPENSIVE_TYPE_NAMES = TYPES
  .filter(type => type.isExpensive)
  .map(type => type.name);
const FAST_EFFECTIVE_TYPE_NAMES = ["5g", "4g", "3g"];

function updateConnectionStatus() {
  if (connection) {
    connectionDetails.speed = connection.effectiveType;
    connectionDetails.type = connection.type;
    connectionDetails.isStrong =
      !EXPENSIVE_TYPE_NAMES.includes(connection.type)
      && FAST_EFFECTIVE_TYPE_NAMES.includes(connection.effectiveType);
  } else {
    connectionDetails.speed = "4g";
    connectionDetails.type = "ethernet";
    connectionDetails.isStrong = true;
  }
}

const connectionDetails = {};
updateConnectionStatus();
if (connection) {
  connection.addEventListener("change", updateConnectionStatus);
}

export default connectionDetails;
