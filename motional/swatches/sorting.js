import Color from "./color.js";

const ordered = [...document.querySelectorAll('color-swatch')]
  .sort((a, b) =>
    {

      return (new Color(`#${a.hex}`).to('lch').l) - (new Color(`#${b.hex}`).to('lch').l);
    }
  )
  .filter(a => /asphalt|black|white|ambient/i.test(a.name));
  // .filter(a => {
  //   const clr = new Color(`#${a.hex}`).to('lch');
  //   return clr.c < 10 && clr.h > 230 && clr.h < 290;
  // });
document.querySelector('.colors').innerHTML = '';
ordered.forEach(elt => document.querySelector('.colors').append(elt));
