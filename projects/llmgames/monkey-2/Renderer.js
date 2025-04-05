/**
 * Renderer handles drawing the floor (grid pattern)
 * and the character sprite. It also manages sizing the
 * canvas to fill (cover) the entire browser window
 * while keeping a square aspect ratio.
 */
export class Renderer {
  constructor(canvas, ctx, game) {
    this.canvas = canvas;
    this.ctx = ctx;
    this.game = game;

    // A small offscreen canvas to build a repeating grid pattern
    this.patternCanvas = document.createElement("canvas");
    this.patternCanvas.width = 200;
    this.patternCanvas.height = 200;
    const pctx = this.patternCanvas.getContext("2d");

    // Draw a simple grid
    pctx.fillStyle = "#888";
    pctx.fillRect(0, 0, 200, 200);
    pctx.strokeStyle = "#555";
    pctx.lineWidth = 2;

    for (let i = 0; i <= 200; i += 20) {
      pctx.beginPath();
      pctx.moveTo(i, 0);
      pctx.lineTo(i, 200);
      pctx.stroke();

      pctx.beginPath();
      pctx.moveTo(0, i);
      pctx.lineTo(200, i);
      pctx.stroke();
    }

    // Create the repeating pattern from the offscreen canvas
    this.pattern = ctx.createPattern(this.patternCanvas, "repeat");

    // Load the character sprite
    // Replace 'sprite.png' with the actual file name if different
    this.sprite = new Image();
    this.sprite.src = "./sprite.png";

    // Basic animation info
    // (Adjust if your sprite has a different number of frames)
    this.frameCount = 8; // e.g., 4 frames across
    this.currentFrame = 0;
    this.frameTimer = 0;
    this.frameDuration = 0.1; // seconds per frame
  }

  /**
   * Resize the canvas to always cover the entire screen
   * in a square aspect ratio. If the screen is wider
   * than tall, the square extends horizontally;
   * if taller than wide, it extends vertically.
   */
  resize() {
    const w = window.innerWidth;
    const h = window.innerHeight;
    const size = Math.max(w, h); // cover
    this.canvas.width = size;
    this.canvas.height = size;

    // We'll center the square if the screen is bigger in one dimension
    this.offsetX = (w - size) / 2;
    this.offsetY = (h - size) / 2;
  }

  /**
   * Render is called once per animation frame (rAF).
   * @param {number} dt - The real time (seconds) since last render.
   */
  render(dt) {
    const ctx = this.ctx;
    // Clear the entire canvas
    ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

    // Animate the walking sprite if desired
    this.frameTimer += dt;
    if (this.frameTimer >= this.frameDuration) {
      this.frameTimer -= this.frameDuration;
      this.currentFrame = (this.currentFrame + 1) % this.frameCount;
    }

    // We'll set up a transform so that:
    // 1 game unit in the "camera" = the entire canvas dimension
    // The camera sees exactly 1×1 area around this.game.camera.x,y
    const size = this.canvas.width; // (square)
    const scale = size / 1; // camera is 1×1 in game units
    const camX = this.game.camera.x;
    const camY = this.game.camera.y;
    const halfView = 0.5; // half of the 1×1 camera

    // Fill the floor (grid pattern) across the entire world
    ctx.save();
    ctx.translate(this.offsetX, this.offsetY);

    // Convert from game world coords to screen coords:
    // 1) scale up by "scale"
    // 2) translate so the camera center is at the center of the screen
    ctx.scale(scale, scale);
    ctx.translate(-(camX - halfView), -(camY - halfView));

    // Draw the entire 3×3 world
    ctx.fillStyle = this.pattern;
    ctx.beginPath();
    ctx.rect(0, 0, this.game.worldWidth, this.game.worldHeight);
    ctx.fill();

    // Draw the character
    const char = this.game.character;
    const spriteWidth = this.sprite.width / this.frameCount;
    const spriteHeight = this.sprite.height;
    const sx = this.currentFrame * spriteWidth;
    const sy = 0;

    // Center the sprite at (char.x, char.y).
    // We'll rotate so that angle=0 means facing up (i.e., -90° from normal “facing right”).
    ctx.save();
    ctx.translate(char.x, char.y);
    ctx.rotate(char.angle - Math.PI * 0.5);
    // The character's size in game units is char.size, so we draw that big
    const drawSize = char.size;
    ctx.drawImage(
      this.sprite,
      sx,
      sy, // source x,y in the sprite
      spriteWidth,
      spriteHeight,
      -drawSize / 2,
      -drawSize / 2, // draw so it is centered on x,y
      drawSize,
      drawSize
    );
    ctx.restore();

    ctx.restore();
  }
}
