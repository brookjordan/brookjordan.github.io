import { html } from "../helpers/html.js";

/**
 * @typedef {import("../endpoint-types/me.js").User} User
 **/

/**
 * @param {Object} params
 * @param {User} params.user
 */
function UserDetails({ user }) {
  return html`<div class="user-details">
    ${user
      ? html`<h2>
          <a href="${user.external_urls.spotify}">${user.display_name}</a>
        </h2>`
      : html`<p>No user data</p>`}
  </div>`;
}

export default UserDetails;
