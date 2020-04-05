export function LCH_to_sRGB_string(l, c, h, a = 100, forceInGamut = true) {
	if(isLCH_within_sRGB(l,c,h)) {
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
	return null;
}

export function isLCH_within_sRGB(l, c, h) {
	const rgb = LCH_to_sRGB([+l, +c, +h]);
	const ε = .000005;
	return rgb.reduce((a, b) => a && b >= (0 - ε) && b <= (1 + ε), true);
}
