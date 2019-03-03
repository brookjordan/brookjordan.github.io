var randomNames = (function randomLetters() {
  var r = {
    lu: {
      a: 8.167,
      b: 1.492,
      c: 2.782,
      d: 4.253,
      e: 12.702,
      f: 2.228,
      g: 2.015,
      h: 6.094,
      i: 6.966,
      j: 0.153,
      k: 0.772,
      l: 4.025,
      m: 2.406,
      n: 6.749,
      o: 7.507,
      p: 1.929,
      q: 0.095,
      r: 5.987,
      s: 6.327,
      t: 9.056,
      u: 2.758,
      v: 0.978,
      w: 2.360,
      x: 0.151,
      y: 1.974,
      z: 0.074,
    },
    vs: 'aeiouy'.split(''),
    cs: 'bcdfghjklmnpqrstvwxyz'.split(''),
    get ls() { return [...r.vs, ...r.cs] },
    np: [
      'cv'.split(''),
      'vc'.split(''),
      'cvc'.split(''),
      'cvcv'.split(''),
      'cvlc'.split(''),
      'ccvlc'.split(''),
      'cvccc'.split(''),
      'cvccvc'.split(''),
      'cvcvcv'.split(''),
      'vclvcvcl'.split(''),
    ],
    r(from = [...r.vs, ...r.cs], ratios = r.lu) {
      const total = from.reduce((acc, cv) => acc + ratios[cv], 0);
      const toOne = 1 / (total - ratios[from[from.length - 1]]);
      const rdm   = Math.random();
      let i       = 0;
      let val     = 0;
      do {
        val += ratios[from[i]] * toOne;
        i   += 1;
      } while (val < rdm)

      return from[i - 1];
    },
    get p() {
      return r.np[Math.floor(Math.random() * r.np.length)];
    },
    get c() {
      return r.r(r.cs);
    },
    get v() {
      return r.r(r.vs);
    },
    get l() {
      return r.r(r.ls);
    },
    get w() {
      return r.p.reduce((acc, cv, i) => i ? acc + r[cv] : r[cv].toUpperCase(), '');
    },
    get s() {
      return Math.random() < 0.05 ? `${r.w}-${r.w}` : r.w;
    },
    get n() {
      return Math.random() > 0.8 ? Math.random() > 0.8 ? `${r.s} ${r.s} ${r.s} ${r.s}` : `${r.s} ${r.s} ${r.s}` : `${r.s} ${r.s}`;
    },
  };
  return r;
}());
