import Vibrant            from '../vendor/vibrant.js';
import { canvasRGB as blurRGB }          from '../vendor/stack-blur.js';
import video, { onReady } from '../src/video.js';

const SWATCH_TYPES = [
  { name : 'LightVibrantSwatch' },
  { name : 'VibrantSwatch' },
  { name : 'DarkVibrantSwatch' },
  { name : 'LightMutedSwatch' },
  { name : 'MutedSwatch' },
  { name : 'DarkMutedSwatch' },
];
let swatchesElt = document.querySelector('.swatches');
let swatchElts  = [];

const CANVAS_SIZE = 500;
let canvas        = document.createElement('canvas');
canvas.width      = CANVAS_SIZE;
canvas.height     = CANVAS_SIZE;
canvas.className  = 'canvas';
document.body.appendChild(canvas);
let ctx           = canvas.getContext('2d');

let df = document.createDocumentFragment();
SWATCH_TYPES.forEach((swatch) => {
  let swatchElt = buildSwatch(swatch.name);
  swatch.elt    = swatchElt;
  df.appendChild(swatchElt);
});
swatchesElt.innerHTML = '';
swatchesElt.appendChild(df);

onReady(() => { console.log(video); buildVibrant(video); });

function buildVibrant(image) {
  ctx.drawImage(image, 0, 0, CANVAS_SIZE, CANVAS_SIZE);
  blurRGB(canvas, 0, 0, CANVAS_SIZE, CANVAS_SIZE, CANVAS_SIZE / 10);
  let vb = new Vibrant(
    canvas,
    64, /* amount of colors in initial palette from which the swatches will be generated, defaults to 64 */
    1 /* quality. 0 is highest, but takes way more processing. defaults to 5. */
  );

  SWATCH_TYPES.forEach(({ name, elt }) => {
    if (vb[name] && /Swatch$/.test(name)) {
      updateSwatch(elt, vb[name].rgb, vb[name].hsl);
    }
  });


  setTimeout(() => { buildVibrant(image); }, 500);
}

function buildSwatch(name) {
  let swatch = document.createElement('div');
  swatch.className = `swatch swatch--${ name }`;
  swatch.innerHTML = `
    <span>
      ${ name.replace(/([A-Z])/g, ' $1').trim() }
    </span>
  `;
  return swatch;
}

function updateSwatch(elt, rgb, hsl) {
  if (!rgb || !hsl) {
    elt.classList.add('swatch--old');
    return;
  } else {
    elt.classList.remove('swatch--old');
  }
  let txt    = hsl[2] > 0.5
    ? 'black'
    : 'white';
  elt.style.backgroundColor = `rgb(${ rgb })`;
  elt.style.color           = txt;
}
