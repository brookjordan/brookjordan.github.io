import { items } from "./items.js";
import { initialiseSpinner } from "../../scripts/spinner.js";

function getDesiredCount() {
  return +new URLSearchParams(location.search).get("count") || 5;
}

const spinnerElt = document.createElement("div");

document.body.appendChild(spinnerElt);
initialiseSpinner(spinnerElt, items, {
  desiredNameCount: getDesiredCount(),
  friction: 0.01,
  storageKey: "cloudapps-nameFilter",
});
