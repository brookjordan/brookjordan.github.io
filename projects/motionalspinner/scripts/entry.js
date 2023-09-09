import { items } from "./items.js";
import { initialiseSpinner } from "./spinner.js";

function getDesiredCount() {
  return +new URLSearchParams(location.search).get("count") || 5;
}

const body = document.body;
const spinnerElt = document.createElement("div");

const peopleInDemo = [
  "Brandon Jie Yi Lam",
  "Brandon Ong",
  "Brook Jordan",
  "Hung Viet Nguyen",
  "Katya Daskalova",
  "Marcellus Reinaldo Jodihardja",
  "Marco Mandrioli",
  "Namith",
  "Nicholas Tan Xuan",
  "Olzhas Kaiyrakhmet",
  "Panteley Boyadjiev",
  "Robin Yeh",
  "Sadaananth Anbucheliyan",
  "Sarah Neo",
  "Sergei Stepanov",
  "Shen Rui Chong",
  "Stacey Ng",
  "Thanh Tam Hoang",
  "Tudor Gergely",
  "Wei Jian Chen",
  "William Kar Hoong Yoong",
];

body.appendChild(spinnerElt);
initialiseSpinner(spinnerElt, items, {
  desiredNameCount: getDesiredCount(),
  friction: 0.01,
  initialItemNames: peopleInDemo,
});
