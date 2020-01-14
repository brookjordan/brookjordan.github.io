function sortByScore(a, b) {
	if (a.score === b.score) {
		return a.string.localeCompare(b.string);
	} else {
		return b.score - a.score;
	}
}

function getWordData(searchTerm, string) {
	let parts = [];
	let broken = "";
	let finding = "";
	let spare = "";
	let matchLength = 0;
	let baseScore = 0;
	let multiplier = 1;

	string.split("").forEach((character, i) => {
		//  If we’re at a space, try to do as little as possible
		if (/\s/.test(character)) {
			if (finding.length) {
				//  Prevent words with trailing spaces
				spare += character;
			} else {
				broken += character;
			}
		}

		//  If we’re matching, add to the matching score
		else if (character.toLowerCase() === searchTerm[matchLength]) {
			if (broken.length) {
				parts.push({
					isUsed: false,
					value: broken
				});
			}

			broken = "";
			if (i === 0) {
				multiplier += 4;
			} else {
				multiplier += 2 / i;
			}

			finding += `${spare}${character}`;
			spare = "";

			do {
				++matchLength;
			} while (/\s/.test(searchTerm[matchLength]))
		}

		//  Otherwise store then kill the current match we’re building
		else {
			if (finding.length) {
				parts.push({
					isUsed: true,
					value: finding,
				});
				finding = "";
			}

			broken += `${spare}${character}`;
			spare = "";
		}
	});

	//  Clean up loose ends
	if (finding.length) {
		parts.push({
			isUsed: true,
			value: finding,
		});
	}
	if (broken.length) {
		parts.push({
			isUsed: false,
			value: broken,
		});
	}

	if (!searchTerm.length || parts.length && matchLength) {
		let formatted;
		formatted = parts
			.map((part) => {
				if (part.isUsed) {
					baseScore += 3 ** part.value.replace(/\s/g, "").length;
					return `<strong>${part.value}</strong>`;
				} else {
					return part.value;
				}
			})
			.join("");

		return {
			parts,
			string,
			baseScore,
			formatted,
			searchTerm,
			score: baseScore * multiplier,
			isFullMatch: matchLength === searchTerm.length,
		};
	}
}

export default function getFuzzyMatchArray(searchTerm, wordsList, sort) {
	let lowerCasedSearchTerm = searchTerm.toLowerCase();
	let matches = wordsList
		.map(word => getWordData(lowerCasedSearchTerm, word))
		.filter(_ => !!_);

	if (!!sort) {
		matches.sort(sortByScore);
	}

	return matches;
}
