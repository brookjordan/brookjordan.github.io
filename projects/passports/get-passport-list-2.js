let countryRequirementReferences = [];

let countryLinks = [...document.querySelectorAll("[href$='_passport']")].map((passportLink) => {
  let countryName = passportLink.textContent.trim();
  let passportURL = passportLink.href;

  return async function() {
    let window2 = window.open(passportURL, "passport", "width=300,height=300");
    let data = {};
    try {
      await new Promise((res, rej) => {
        let done = false;
        window2.onload = () => {
          if (!done) {
            done = true;
            res();
          }
        }
        setTimeout(() => {
          if (!done) {
            done = true;
            rej(`Timeout: ${countryName}`);
          }
        }, 5000);
      });
      let requirementsLink = [...window2.document.querySelectorAll("a")].find(a => a.textContent.toLowerCase().includes("visa requirements for "));
      let requirementsURL = requirementsLink && requirementsLink.href;
      let countryLabel = countryName;
      if (!countryLabel) {
        let countryLabelElt = [...window2.document.querySelectorAll("th,td")].find(a => a.textContent.toLowerCase().includes("issued by"));
        countryLabel = countryLabelElt && countryLabelElt.nextElementSibling && countryLabelElt.nextElementSibling.textContent.trim();
      }
      let countryPosessiveMatch = window2.location.href.match(/\/([^/]+?)_passport/);
      let countryPosessive = countryPosessiveMatch && countryPosessiveMatch[1];
      data = {
        requirementsURL,
        countryLabel,
        countryPosessive,
      };
    } catch (error) {
      console.log(error);
    }
    await window2.close();
    return data;
  };
}).filter(_ => _);

(async function() {
  while (countryLinks.length) {
    let countryLink = await (countryLinks.pop())();
    countryRequirementReferences.push(countryLink);
    if (countryLink) {
      console.log(`Added: ${countryLink.countryLabel}`);
    } else {
      console.log(`Some issue with:`);
      console.log(countryLink);
    }
  }
})();
