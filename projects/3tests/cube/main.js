import {
  camera,
  renderer,
  scene,
} from './parts.js';
import './camera-controls.js';
import './light-controls.js';
import './cube-controls.js';

document.body.appendChild( renderer.domElement );
render();

function render() {
  requestAnimationFrame( render );

	renderer.render( scene, camera );
}
