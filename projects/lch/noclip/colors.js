export function LCH_to_sRGB_string(l, c, h, a = 100, forceInGamut = false) {
	if (forceInGamut) {
		[l,c,h] = force_into_sRGB_gamut(l,c,h);
	}
	return "rgb(" + LCH_to_sRGB([+l, +c, +h]).map(x => {
		return Math.round(x * 10000)/100 + "%"
	}).join(" ") + (a < 100? ` / ${a}%` : "") + ")"
}

export function force_into_sRGB_gamut(l, c, h) {
	// Moves an lch color into the sRGB gamut
	// by holding the l and h steady,
	// and adjusting the c via binary-search
	// until the color is on the sRGB boundary.
	if(isLCH_within_sRGB(l,c,h)) return [l,c,h];
	let hiC = c;
	let loC = 0;
	c /= 2;
	// .0001 chosen fairly arbitrarily as "close enough"
	while(hiC - loC > .0001) {
		if(isLCH_within_sRGB(l,c,h)) {
			loC = c;
		} else {
			hiC = c;
		}
		c = (hiC + loC)/2;
	}
	return [l,c,h];
}

export function isLCH_within_sRGB(l, c, h) {
	var rgb = LCH_to_sRGB([+l, +c, +h]);
	const ε = .000005;
	return rgb.reduce((a, b) => a && b >= (0 - ε) && b <= (1 + ε), true);
}
