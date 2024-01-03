import { items } from "./items.js";
import { initialiseSpinner } from "./spinner.js";

function getDesiredCount() {
  return +new URLSearchParams(location.search).get("count") || 5;
}

const body = document.body;
const spinnerElt = document.createElement("div");

const peopleInDemo = [
  // "Alan Z",
  // "Arnaud Michel Jacques Lago",
  // "Brandon Jie Yi Lam",
  "Brandon Ong",
  "Brook Jordan",
  // "Eduard Nabokov",
  // "Fil Mihaylov",
  "Hung Viet Nguyen",
  // "Ivan Petkov",
  "Kakali Basak",
  // "Katya Daskalova",
  "Marcellus Reinaldo Jodihardja",
  "Marco Mandrioli",
  // "Minsung Cho",
  // "Namith",
  "Nicholas Tan Xuan",
  "Olzhas Kaiyrakhmet",
  // "Panteley Boyadjiev",
  // "Plamen",
  // "Quanjie Yang",
  "Robin Yeh",
  // "Sadaananth Anbucheliyan",
  "Sarah Neo",
  "Sergei Stepanov",
  "Shen Rui Chong",
  "Stacey Ng",
  "Thanh Tam Hoang",
  "Tian Fu Tan",
  "Tudor Gergely",
  // "Wan Jou Lim",
  // "Wee Kiat Clarence Ang",
  "Wei Jian Chen",
  // "William Kar Hoong Yoong",
  "Zizhang Ai",
];

body.appendChild(spinnerElt);
initialiseSpinner(spinnerElt, items, {
  desiredNameCount: getDesiredCount(),
  friction: 0.01,
  initialItemNames: peopleInDemo,
});
