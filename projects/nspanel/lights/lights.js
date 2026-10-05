const lights = document.querySelector(".lights");
const lightsButton = document.querySelector(".lights__button--ceiling");

let lightIsOn = false;

lightsButton.addEventListener("pointerdown", () => {
  lightIsOn = !lightIsOn;
  lightsButton.classList[lightIsOn ? "add" : "remove"]("lights__button--is-on");
  lightsButton.classList[lightIsOn ? "add" : "remove"]("chunky-button--is-on");
});
