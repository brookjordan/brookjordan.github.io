import { isHTMLInputElement } from "../helpers/isHTMLInputElement.js";
import { html } from "../helpers/html.js";

/**
 * @param {Object} params
 * @param {(newValue: string | null) => void} params.onChange
 * @param {string} params.value
 * @param {string[]} params.genreList
 */
function GenreList({ onChange, value, genreList }) {
  /**
   * @param {Event} event
   */
  const handleGenreChange = (event) => {
    if (!isHTMLInputElement(event.target)) return;

    onChange(value === event.target.value ? null : event.target.value);
  };

  return html`<div class="genre-list">
    ${!genreList || genreList.length === 0
      ? html`<p>No genres provided</p>`
      : genreList.map(
          (genreName) =>
            html`<label id="genre__${genreName}">
              <input
                for="genre__${genreName}"
                type="checkbox"
                name="genres"
                value="${genreName}"
                checked=${value === genreName}
                onChange=${handleGenreChange}
              />
              <span>${genreName}</span>
            </label>`,
        )}
  </div>`;
}

export default GenreList;
