function getPassportStrength(table = document.querySelector("table"), {
  countryNameCol,
  visaRequirementsCol,
  stayLengthCol,
  notesCol,
  reciprocityCol,
} = {}) {
  /** EASE LEVELS
   * 0: not-required
   * 1: on-arrival
   * 2: pre-purchase
   * 3: special-requirements
   * 4: no-entry
   * 5: unknown
   */

  const VISA_EASES = {
    "visa not required": 0,
    "right of abode": 0,
    "visa waiver program": 0,
    "freedom of movement": 0,
    "visa on arrival": 1,
    "free visa on arrival": 1,
    "entry permit on arrival": 1,
    "with home return permit": 1,
    "tourist card on arrival": 1,
    "visitor permit on arrival": 1,
    "conditional visa on arrival": 1,
    "free entry permit on arrival": 1,
    "visa on arrival (conditional)": 1,
    "free visitor permit on arrival": 1,
    "evisa": 2,
    "evisitor": 2,
    "ttp required": 2,
    "e tourist card": 2,
    "electronic authorisation": 2,
    "electronic travel authority": 2,
    "online visa": 2,
    "visa required": 2,
    "permit required": 2,
    "permission required": 2,
    "electronic entry visa": 2,
    "tourist card required": 2,
    "electronic travel authorization": 2,
    "travel permit required": 2,
    "pap or rap required": 2,
    "ovir permit required": 2,
    "entry permit required": 2,
    "pre registration required": 2,
    "restricted area": 3,
    "special permit required": 3,
    "special permission required": 3,
    "access permit required": 3,
    "special authorisation required": 3,
    "special permits required": 3,
    "restricted zone": 3,
    "admission refused": 4,
  };

  const VISA_TYPES = [
    "evisa",
  ];

  return JSON.stringify([...table.querySelectorAll("tr")].slice(1).map((row, rowIndex) => {
    if (row.querySelectorAll("td").length < 2) { return; }

    let visaRequirements;
    let easeOfEntry = 5;
    let visaTypes = [];
    if (visaRequirementsCol) {
      visaRequirements = row.querySelector(`td:nth-child(${visaRequirementsCol})`)
        .textContent.trim().toLowerCase()
        .replace(/[’']s\b/g, "")
        .replace(/e\-visa/g, "evisa")
        .replace(/\[\d+\]/g, "")
        .replace("pap/rap", "pap or rap")
        .split("/").map(a => a.trim().replace(/[-\s]+/g, " "))
        .filter(_ => _);


      visaRequirements.forEach((visaRequirement) => {
        if (VISA_TYPES.includes(visaRequirement)) {
          visaTypes.push(visaRequirement);
        }
        if (typeof VISA_EASES[visaRequirement] !== "undefined") {
          easeOfEntry = Math.min(VISA_EASES[visaRequirement], easeOfEntry);
        } else {
          throw Error(`unknown visa requirement: ${visaRequirement}`);
        }
      });
    }

    let reciprocity = null;
    if (reciprocityCol) {
      (function() {
        let symbol = row.querySelector(`td:nth-child(${reciprocityCol})`).textContent.trim();
        if (symbol === "√") {
          return true;
        }
        if (symbol === "X") {
          return false;
        }
        return null;
      }());
    }

    let country = null;
    if (countryNameCol) {
      let countryName = row.querySelector(`td:nth-child(${countryNameCol})`).textContent.trim();
      country = {
        label: countryName,
        name: countryName.toLowerCase().replace(/\s+/g, ' ')
      };
    }
    let stayLength = null;
    if (stayLengthCol) {
      stayLength = row.querySelector(`td:nth-child(${stayLengthCol})`).textContent.trim() || null;
    }
    let notes = null;
    if (notesCol) {
      let notesColElt = row.querySelector(`td:nth-child(${notesCol})`);
      if (!notesColElt) { console.warn(`Missing notes col ${rowIndex}`); }
      else {
        notes = notesColElt.textContent.trim() || null;
      }
    }

    return {
      notes,
      visaTypes,
      stayLength,
      easeOfEntry,
      country: country,
      reciprocity,
      visaRequirements,
    };
  }).filter(_ => _), null, 2);
};

getPassportStrength(document.querySelectorAll("table")[0], {
  countryNameCol: 1,
  visaRequirementsCol: 2,
  stayLengthCol: 3,
  notesCol: 4,
  reciprocityCol: 5,
});
