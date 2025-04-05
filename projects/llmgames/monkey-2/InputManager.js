/**
 * Manages keyboard (or controller) input.
 * You can easily extend this to remap keys,
 * add new controls, or support gamepads.
 */
export class InputManager {
  constructor(game) {
    this.game = game;

    // Key bindings (easy to change)
    this.keys = {
      forward: "ArrowUp",
      // left: 'ArrowLeft',
      // right: 'ArrowRight',
    };

    // Bind event handlers
    this.onKeyDown = this.onKeyDown.bind(this);
    this.onKeyUp = this.onKeyUp.bind(this);

    window.addEventListener("keydown", this.onKeyDown);
    window.addEventListener("keyup", this.onKeyUp);
  }

  onKeyDown(e) {
    if (e.key === this.keys.forward) {
      this.game.character.movingForward = true;
    }
    /*
    if (e.key === this.keys.left) {
      this.game.character.rotatingLeft = true;
    }
    if (e.key === this.keys.right) {
      this.game.character.rotatingRight = true;
    }
    */
  }

  onKeyUp(e) {
    if (e.key === this.keys.forward) {
      this.game.character.movingForward = false;
    }
    /*
    if (e.key === this.keys.left) {
      this.game.character.rotatingLeft = false;
    }
    if (e.key === this.keys.right) {
      this.game.character.rotatingRight = false;
    }
    */
  }
}
