import { Scene } from './node_modules/three/src/scenes/Scene.js';
import { PerspectiveCamera } from './node_modules/three/src/cameras/PerspectiveCamera.js';
import { WebGLRenderer } from './node_modules/three/src/renderers/WebGLRenderer.js';
import { BoxGeometry } from './node_modules/three/src/geometries/BoxGeometry.js';
//import { MeshBasicMaterial } from './node_modules/three/src/materials/MeshBasicMaterial.js';
import { MeshPhongMaterial } from './node_modules/three/src/materials/MeshPhongMaterial.js';
import { Mesh } from './node_modules/three/src/objects/Mesh.js';
import { DirectionalLight } from './node_modules/three/src/lights/DirectionalLight.js';

export let scene = new Scene();
export let camera = new PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

export let renderer = new WebGLRenderer({ antialias: true, precision: 'lowp' });
renderer.setSize( window.innerWidth, window.innerHeight );

let geometry = new BoxGeometry();
let material = new MeshPhongMaterial( { color: 0xffffff } );
export let cube = new Mesh( geometry, material );
scene.add( cube );

export let directionalLight = {
  red: new DirectionalLight( 0xff0000, 1 ),
  green: new DirectionalLight( 0x00ff00, 1 ),
  blue: new DirectionalLight( 0x0000ff, 1 ),
};
let addDirectionalLight = (name, {
  color,
  position = { x: 0, z: 0, y: 1 },
  intensity = 1,
} = {}) => {
  directionalLight[name] = new DirectionalLight( color, intensity );
  directionalLight[name].translateX(position.x);
  directionalLight[name].translateY(position.y);
  directionalLight[name].translateZ(position.z);
  scene.add( directionalLight[name] );
};

addDirectionalLight('red', {
  color: 0xff0000,
  position: { x: 4, y: 3, z: 2 },
});
addDirectionalLight('green', {
  color: 0x00ff00,
  position: { x: 3, y: -6, z: 2 },
});
addDirectionalLight('blue', {
  color: 0x0000ff,
  position: { x: -4, y: 1, z: 0 },
});
