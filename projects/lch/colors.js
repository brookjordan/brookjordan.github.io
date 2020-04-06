export function LCH_to_sRGB_string([l, c, h, a = 100] = [], outOfGamut = "null") {
	if(!isLCH_within_sRGB(l,c,h)) {
		if (typeof outOfGamut === "number" && outOfGamut > 0 && outOfGamut < 100) {
			[l,c,h,] = interpolated_sRGB_gamut(l,c,h);
			a = outOfGamut;
		} else if (outOfGamut === "null" || (typeof outOfGamut === "number" && outOfGamut <= 0)) {
			return null;
		} else if (outOfGamut === "full" || (typeof outOfGamut === "number" && outOfGamut >= 100)) {
			[l,c,h] = interpolated_sRGB_gamut(l,c,h);
		} else {
			throw `Invalid out of gamut value "${outOfGamut}" provided`
		}
	}

	return `rgb(${
		LCH_to_sRGB([+l, +c, +h]).map(x => `${
			Math.round(x * 10000)/100
		}%`)
	}${
		a < 100
			? `, ${a}%`
			: ""
	})`;
}

export function interpolated_sRGB_gamut(l, c, h) {
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
