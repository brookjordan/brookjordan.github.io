function getMostCommonColour(src, count=4) {
  return new Promise((resolve, reject) => {
    const canvas = document.createElement('canvas');
    const ctx    = canvas.getContext('2d');
    const img    = new Image();

    img.crossOrigin = "Anonymous";
    img.addEventListener('load', doIt);

    img.src = src;

    function doIt(e) {
      canvas.width = img.naturalWidth;
      canvas.height = img.naturalHeight;

      ctx.drawImage(img, 0, 0);

      const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height).data;
      const pixels       = [];
      const colours      = {};
      const coloursA     = [];

      for (let i = 0; i < imageData.length; i += 4) {
        pixels.push(imageData.slice(i, i+4));
      }

      pixels.forEach(pixel => {
        if (pixel[3] !== 255) { return; }
        const str = pixel.map(num => Math.floor(num / 10)).join(',');
        colours[str] = colours[str] ? colours[str] + 1 : 1;
      });

      Object.keys(colours).forEach(colorName => {
        coloursA.push({
          rgba:  colorName.split(',').map(x => x * 10 + 5),
          count: colours[colorName],
        });
      });
      coloursA.sort(sortColours).reverse();

      //  Return the top count colours
      const domCol = [];
      while (count && coloursA.length) {
        const colour = coloursA.shift();
        if (rgbToHsl(...colour.rgba)[2] > 0.1) {
          domCol.push(colour);
          count -= 1;
        }
      }
      
      resolve(domCol);
    }
  });
      
  function chooseDominant(a, b) {
    const [hueA, satA, briA] = rgbToHsl(...a.rgba);
    const [hueB, satB, briB] = rgbToHsl(...b.rgba);
    if (b.count * 5 > a.count && (briA < 0.08 || briA > 0.9 || satA < 0.05) && briB > 0.2 && satB > 0.1) {
      return b;
    }
    if (b.count * 2 > a.count && satB > satA * 1.3 && briB > 0.2 && briB < 0.7) {
      return b;
    } else {
      return a;
    }
  }

  function sortColours(a, b) {
    if (a.count > b.count) { return 1; }
    if (a.count < b.count) { return -1; }
    return 0;
  }

  function rgbToHsl(r, g, b){
      r /= 255, g /= 255, b /= 255;
      var max = Math.max(r, g, b), min = Math.min(r, g, b);
      var h, s, l = (max + min) / 2;

      if(max == min){
          h = s = 0; // achromatic
      }else{
          var d = max - min;
          s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
          switch(max){
              case r: h = (g - b) / d + (g < b ? 6 : 0); break;
              case g: h = (b - r) / d + 2; break;
              case b: h = (r - g) / d + 4; break;
          }
          h /= 6;
      }

      return [h, s, l];
  }
}
