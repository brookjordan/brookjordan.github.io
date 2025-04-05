import { Game } from "./Game.js";
import { Renderer } from "./Renderer.js";
import { InputManager } from "./InputManager.js";

// Grab the canvas and 2D context
const canvas = document.getElementById("gameCanvas");
const ctx = canvas.getContext("2d");

// Create our main modules
const game = new Game();
const renderer = new Renderer(canvas, ctx, game);
const input = new InputManager(game);

// Fixed timestep (simulation) in milliseconds
const SIM_STEP = 1000 / 60; // 60 updates per second
let lastTime = performance.now();
let accumulatedTime = 0;

/**
 * Main loop (requestAnimationFrame).
 * - We accumulate the time since the last frame
 * - We step the game simulation at a fixed rate
 * - We render once per rAF call (i.e., unlocked from the sim rate)
 */
function loop(timestamp) {
  const delta = timestamp - lastTime;
  lastTime = timestamp;
  accumulatedTime += delta;

  // Update simulation at fixed intervals
  while (accumulatedTime >= SIM_STEP) {
    // Convert ms to seconds for game.update
    game.update(SIM_STEP / 1000);
    accumulatedTime -= SIM_STEP;
  }

  // Render with the real time delta (in seconds)
  renderer.render(delta / 1000);

  requestAnimationFrame(loop);
}

// Handle resizing to cover the screen
window.addEventListener("resize", () => renderer.resize());
renderer.resize();

// Start the game loop
requestAnimationFrame(loop);
