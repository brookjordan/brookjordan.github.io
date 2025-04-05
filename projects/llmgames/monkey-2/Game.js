/**
 * Game holds all core logic:
 * - World size (3x3 in "game units")
 * - Character data (position, forward speed)
 * - Camera data (position, smoothing)
 * - update(dt) for stepping the simulation
 */
export class Game {
  constructor() {
    // Our "world" is 3x the 1x1 reference
    this.worldWidth = 3;
    this.worldHeight = 3;

    // Character state
    this.character = {
      x: this.worldWidth / 2,
      y: this.worldHeight / 2,
      angle: 0, // facing "up" in 2D? We'll just keep 0 if not rotating
      size: 0.08, // 8% of the 1x1 camera area
      speed: 0.8, // forward speed (units per second)
      movingForward: false,

      // If you want turning, uncomment these:
      // rotatingLeft: false,
      // rotatingRight: false,
      // rotationSpeed: 1.5, // radians/sec
    };

    // Camera (views a 1x1 area, clamped to 0..3 in both axes)
    this.camera = {
      x: this.character.x,
      y: this.character.y,
    };

    // Camera lag factor (0.1 is fairly "smooth")
    this.cameraLag = 0.1;
  }

  update(dt) {
    // If moving forward, move along the character's facing angle
    if (this.character.movingForward) {
      this.character.x +=
        Math.cos(this.character.angle) * this.character.speed * dt;
      this.character.y +=
        Math.sin(this.character.angle) * this.character.speed * dt;
    }

    // If you want turning:
    /*
    if (this.character.rotatingLeft) {
      this.character.angle -= this.character.rotationSpeed * dt;
    }
    if (this.character.rotatingRight) {
      this.character.angle += this.character.rotationSpeed * dt;
    }
    */

    // Clamp character within the world
    if (this.character.x < 0) this.character.x = 0;
    if (this.character.x > this.worldWidth) this.character.x = this.worldWidth;
    if (this.character.y < 0) this.character.y = 0;
    if (this.character.y > this.worldHeight)
      this.character.y = this.worldHeight;

    // Smooth camera approach to character
    this.camera.x += (this.character.x - this.camera.x) * this.cameraLag;
    this.camera.y += (this.character.y - this.camera.y) * this.cameraLag;

    // Camera sees 1x1, so half of that is 0.5
    const halfView = 0.5;

    // Clamp camera so it never goes beyond world edges
    if (this.camera.x < halfView) this.camera.x = halfView;
    if (this.camera.x > this.worldWidth - halfView) {
      this.camera.x = this.worldWidth - halfView;
    }
    if (this.camera.y < halfView) this.camera.y = halfView;
    if (this.camera.y > this.worldHeight - halfView) {
      this.camera.y = this.worldHeight - halfView;
    }
  }
}
