const clothes = document.querySelector(".clothes");
const clothesAlertButton = document.querySelector(".clothes__button--alert");
const clothesWasherValue = document.querySelector(".clothes__value--washer");
const clothesDrierValue = document.querySelector(".clothes__value--drier");

clothesAlertButton.addEventListener("pointerdown", () => {
  clothesAlertButton.classList.toggle("clothes__button--is-on");
  clothesAlertButton.classList.toggle("chunky-button--is-on");
});

setInterval(() => {
  clothesWasherValue.classList[Math.random() > 0.2 ? "add" : "remove"](
    "screen-value--is-on"
  );
  clothesDrierValue.classList[Math.random() > 0.2 ? "add" : "remove"](
    "screen-value--is-on"
  );
}, 2000);
