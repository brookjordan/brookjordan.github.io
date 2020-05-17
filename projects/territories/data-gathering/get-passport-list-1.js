let countryRequirementReferences = [];

let countryLinks = [...document.querySelectorAll(".gallerybox")].map((gallerybox) => {
  let flagIcon = gallerybox.querySelector(".flagicon");
  if (!flagIcon) { return; }

  let passportLink = flagIcon.nextElementSibling;
  if (passportLink.nodeName.toUpperCase() !== "A") {
    passportLink = passportLink.querySelector("a");
  }
  if (passportLink.nodeName.toUpperCase() !== "A") {
    console.log(passportLink); return;
  }

  let countryName = passportLink.textContent.trim();
  let passportURL = flagIcon.nextElementSibling;

  return async function() {
    let window2 = window.open(passportURL, "passport", "width=300,height=300");
    await new Promise(res => { window2.onload = res; });
    let requirementsLink = [...window2.document.querySelectorAll("a")].find(a => a.textContent.toLowerCase().includes("visa requirements for "));
    let requirementsURL = requirementsLink && requirementsLink.href;
    let countryLabel = countryName;
    if (!countryLabel) {
      let countryLabelElt = [...window2.document.querySelectorAll("th,td")].find(a => a.textContent.toLowerCase().includes("issued by"));
      countryLabel = countryLabelElt && countryLabelElt.nextElementSibling && countryLabelElt.nextElementSibling.textContent.trim();
    }
    let demonymMatch = window2.location.href.match(/\/([^/]+?)_passport/);
    let demonym = demonymMatch && demonymMatch[1];
    let data = {
      requirementsURL,
      countryLabel,
      demonym,
    };
    await window2.close();
    return data;
  };
}).filter(_ => _);

(async function() {
  while (countryLinks.length) {
    let countryLink = await (countryLinks.pop())();
    countryRequirementReferences.push(countryLink);
    console.log(`Added: ${countryLink.countryLabel}`);
  }
})();
