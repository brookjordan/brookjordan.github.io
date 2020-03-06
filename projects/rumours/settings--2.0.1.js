let sidebarUnderlay = document.createElement("div");
sidebarUnderlay.className = "sidebar-underlay";

let sidebarContainer = document.createElement("div");
sidebarContainer.className = "sidebar-container";

let sidebarWobble = document.createElement("div");
sidebarWobble.className = "sidebar-wobble";

let sidebar = document.createElement("aside");
sidebar.className = "sidebar";
if (searchParams.settings === "true") {
  sidebarContainer.classList.add("sidebar-container--open");
}
sidebarContainer.appendChild(sidebarWobble);
sidebarContainer.appendChild(sidebar);

let sidebarToggle = document.createElement("button");
sidebarToggle.className = "sidebar__toggle";
sidebarToggle.setAttribute("aria-label", "Toggle settings");

let sidebarToggleIcon = document.createElement("i");
sidebarToggleIcon.className = "sidebar__toggle-icon";
sidebarToggle.appendChild(sidebarToggleIcon);


let peopleElt = document.createElement("div");
peopleElt.className = "people";
sidebar.appendChild(peopleElt);


printPeople();
document.body.appendChild(sidebarContainer);
document.body.appendChild(sidebarUnderlay);
document.body.appendChild(sidebarToggle);



sidebarUnderlay.addEventListener("click", toggleSidebar);
sidebarToggle.addEventListener("click", toggleSidebar);


function toggleSidebar() {
  if (sidebarContainer.classList.contains("sidebar-container--open")) {
    delete searchParams.settings;
  } else {
    searchParams.settings = "true";
  }
  sidebarContainer.classList.toggle("sidebar-container--open");
}

function printPeople(focus) {
  var peopleFragment = document.createDocumentFragment();

  let girlsTitle = document.createElement("h2");
  girlsTitle.textContent = "Girls";
  peopleFragment.appendChild(girlsTitle);
  globalGirls.forEach(girl => {
    let girlElt = document.createElement("button");
    girlElt.className = "remove-name";
    girlElt.textContent = `${girl} `;
    girlElt.innerHTML += "<span style=\"color:red\">×<span>"
    girlElt.addEventListener("click", e => {
      globalGirls.splice(globalGirls.indexOf(girl), 1);
      localStorage.setItem("girls", globalGirls);
      printPeople();
    });
    peopleFragment.appendChild(girlElt);
  });
  let addGirl = document.createElement("form");
  let addGirlName = document.createElement("input");
  addGirlName.placeholder = "Cecil";
  addGirlName.setAttribute("aria-label", "Girl’s name");
  let addGirlButton = document.createElement("button");
  addGirlButton.textContent = "+";
  addGirl.addEventListener("submit", e => {
    e.preventDefault();
    if (addGirlName.value.trim()) {
      globalGirls.push(addGirlName.value.trim());
      localStorage.setItem("girls", globalGirls);
      printPeople("girl");
    }
  });
  addGirl.appendChild(addGirlName);
  addGirl.appendChild(addGirlButton);
  peopleFragment.appendChild(addGirl);



  let boysTitle = document.createElement("h2");
  boysTitle.textContent = "Boys";
  peopleFragment.appendChild(boysTitle);
  globalBoys.forEach(boy => {
    let boysElt = document.createElement("button");
    boysElt.className = "remove-name";
    boysElt.textContent = `${boy} `;
    boysElt.innerHTML += "<span style=\"color:red\">×<span>"
    boysElt.addEventListener("click", e => {
      globalBoys.splice(globalBoys.indexOf(boy), 1);
      localStorage.setItem("boys", globalBoys);
      printPeople();
    });
    peopleFragment.appendChild(boysElt);
  });
  let addBoy = document.createElement("form");
  let addBoyName = document.createElement("input");
  addBoyName.placeholder = "Hendrick";
  addBoyName.setAttribute("aria-label", "Boy’s name");
  let addBoyButton = document.createElement("button");
  addBoyButton.textContent = "+";
  addBoy.addEventListener("submit", e => {
    e.preventDefault();
    if (addBoyName.value.trim()) {
      globalBoys.push(addBoyName.value.trim());
      localStorage.setItem("boys", globalBoys);
      printPeople("boy");
    }
  });
  addBoy.appendChild(addBoyName);
  addBoy.appendChild(addBoyButton);
  peopleFragment.appendChild(addBoy);



  let namesManip = document.createElement("form");
  namesManip.className = "names-manip";

  let resetDefaults = document.createElement("button");
  resetDefaults.className = "reset-default-names-button";
  resetDefaults.textContent = "Reset to defaults";
  resetDefaults.addEventListener("click", e => {
    e.preventDefault();
    if (confirm("Are you sure you want to reset to defaults? All names you created will be lost.")) {
      setDefaultGlobalNames(false);
      localStorage.setItem("girls", globalGirls);
      localStorage.setItem("boys", globalBoys);
      printPeople();
    }
  });
  namesManip.appendChild(resetDefaults);

  let clearAll = document.createElement("button");
  clearAll.className = "clear-all-names-button";
  clearAll.textContent = "Clear all";
  clearAll.addEventListener("click", e => {
    e.preventDefault();
    if (confirm("Are you sure you want to clear all name? All names you created will be lost.")) {
      globalGirls = [];
      globalBoys = [];
      localStorage.setItem("girls", "");
      localStorage.setItem("boys", "");
      printPeople();
    }
  });
  namesManip.appendChild(clearAll);

  let buildSharingLink = document.createElement("button");
  buildSharingLink.className = "build-sharing-url";
  buildSharingLink.textContent = "Share";
  buildSharingLink.addEventListener("click", e => {
    e.preventDefault();
    let shareURL = `${location.href.split("?")[0]}?girls=${encodeURI(globalGirls)}&boys=${encodeURI(globalBoys)}`;
    // if (navigator.share) {
    //   navigator.share({
    //       title: "Placeholder generator",
    //       text: shareURL,
    //       url: shareURL,
    //   })
    //     .then(() => {})
    //     .catch((error) => {
    //       debugger;
    //       prompt(
    //         "Copy this link and send it to your friends!",
    //         shareURL
    //       );
    //       shareViaPrompt();
    //     });
    // } else {
      prompt(
        "Copy this link and share it with your friends!",
        shareURL
      );
    // }
  });
  namesManip.appendChild(buildSharingLink);

  peopleFragment.appendChild(namesManip);


  peopleElt.innerHTML = "";
  peopleElt.appendChild(peopleFragment);

  if (focus === "girl") { addGirlName.focus(); }
  if (focus === "boy") { addBoyName.focus(); }
}
