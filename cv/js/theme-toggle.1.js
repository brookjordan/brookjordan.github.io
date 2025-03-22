const themes = ["light", "dark"];

const themeMetaTags = themes.map((theme) => ({
  theme,
  element: document.querySelector(`#theme-color-meta-${theme}`),
}));

const themeInputs = [...themes, "auto"].map((theme) => ({
  prose: theme,
  element: document.querySelector(`#theme--${theme}`),
}));

const THEME_STORAGE_NAME = "CURRENT_THEME";

const updateTheme = (newTheme) => {
  console.log(newTheme);
  if (newTheme === "auto") {
    localStorage.removeItem(THEME_STORAGE_NAME);
    themeMetaTags.forEach(({ element }) => document.head.append(element));
  } else {
    localStorage.setItem(THEME_STORAGE_NAME, newTheme);
    themeMetaTags.forEach(({ element }) => element.remove());

    const newThemeMetaTag = themeMetaTags.find(
      ({ theme }) => theme === newTheme
    );
    if (!newThemeMetaTag) return;

    document.head.appendChild(newThemeMetaTag.element);
  }
  themeInputs.forEach(({ element }) => element.removeAttribute("checked"));
  themeInputs
    .find(({ prose: theme }) => theme === newTheme)
    .element.setAttribute("checked", "checked");
};

updateTheme(localStorage.getItem(THEME_STORAGE_NAME) || "auto");
themeMetaTags.forEach(({ element }) => element.removeAttribute("media"));

themeInputs.forEach(({ prose: theme, element }) => {
  element.addEventListener("change", () => {
    updateTheme(theme);
  });
});
