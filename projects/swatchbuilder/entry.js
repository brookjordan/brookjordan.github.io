import { fillRect, refreshSize } from "./utils.js";

const lightness = {
  ctx: document.querySelector("#lightness").getContext("2d"),
  get display() {
    let bounds = this.ctx.canvas.getBoundingClientRect();
    return {
      width: bounds.width,
      height: bounds.height,
    };
  },
}

refreshSize(lightness);

(function flash() {
  let x = Math.random() * 50;
  let y = Math.random() * 50;
  fillRect(lightness,
    x,
    y,
    Math.random() * (100 - x),
    Math.random() * (100 - y),
    {
      color: `hsl(${Math.random() * 40 + 120}deg ${Math.random() * 15 + 10}% ${Math.random() * 15 + 40}%)`,
    }
  );
  requestAnimationFrame(flash);
})();
