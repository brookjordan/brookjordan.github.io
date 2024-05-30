import { items } from "./items.js";
import { initialiseSpinner } from "./spinner.js";

function getDesiredCount() {
  return +new URLSearchParams(location.search).get("count") || 5;
}

const body = document.body;
const spinnerElt = document.createElement("div");

const peopleInDemo = [
  "Brook Jordan",
  "Cong Vu",
  "Jingchen Yu",
  "Kenny Reida Dharmawan",
  "Marcellus Reinaldo Jodihardja",
  "Nicholas Tan Xuan",
  "Robin Yeh",
  "Stacey Ng",
  "Tian Fu Tan",
  "Wee Kiat Clarence Ang",

  // "Alan Z",
  // "Arnaud Michel Jacques Lago",
  // "Brandon Jie Yi Lam",
  // "Brandon Ong",
  // "Eduard Nabokov",
  // "Fil Mihaylov",
  // "Hung Viet Nguyen",
  // "Ivan Petkov",
  // "Kakali Basak",
  // "Katya Daskalova",
  // "Marco Mandrioli",
  // "Matt Yang",
  // "Minsung Cho",
  // "Namith",
  // "Olzhas Kaiyrakhmet",
  // "Panteley Boyadjiev",
  // "Plamen",
  // "Quanjie Yang",
  // "Rajnish Kumar",
  // "Sadaananth Anbucheliyan",
  // "Sarah Neo",
  // "Sergei Stepanov",
  // "Shen Rui Chong",
  // "Thanh Tam Hoang",
  // "Tudor Gergely",
  // "Wan Jou Lim",
  // "Wei Jian Chen",
  // "William Kar Hoong Yoong",
  // "Zizhang Ai",
];

body.appendChild(spinnerElt);
initialiseSpinner(spinnerElt, items, {
  desiredNameCount: getDesiredCount(),
  friction: 0.01,
  initialItemNames: peopleInDemo,
});
