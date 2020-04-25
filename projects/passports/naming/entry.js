import links from "../visa-requirements/links.js";

let individualCountryNames = links.flatMap((link) => (
  link.countryNames
));

let individualCitizenshipNamings = individualCountryNames.flatMap((countryNaming) =>
  countryNaming.citizenship.map((citizenship) => ({
    citizenship,
    demonym: countryNaming.demonym,
  }))
);

document.body.innerHTML = `<table>
  <tr>
    <th>People with this citizenship</th>
    <th>Are often called</th>
  ${
    individualCitizenshipNamings.map((naming) => `
  <tr>
    <td>${naming.citizenship}
    <td>${naming.demonym.join(", or ")}
    `).sort((a, b) => a.localeCompare(b)).join("\n")
  }
</table>`;
