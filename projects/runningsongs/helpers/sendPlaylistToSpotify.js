import { bearer } from "../helpers/bearer.js";
import { SPOTIFY_URL_DOMAIN } from "../helpers/getFromSpotify.js";

/**
 * @param {string} userId
 * @param {string} playlistLabel
 * @param {string[]} trackIds
 *
 * @return {Promise<[Error, null] | [null, unknown | null]>}
 */
export const sendPlaylistToSpotify = async (
  userId,
  playlistLabel,
  trackIds,
) => {
  /** @type {Response | null} */
  let response = null;
  /** @type {unknown | null} */
  let data = null;
  const uriList = trackIds.map((trackId) => `spotify:track:${trackId}`);
  const jsonifiedUriList = JSON.stringify({
    uris: uriList,
  });

  try {
    response = await fetch(
      `https://api.spotify.com/v1/users/${userId}/playlists`,
      {
        method: "POST",
        body: JSON.stringify({ name: playlistLabel }),
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${bearer}`,
        },
        mode: "cors",
      },
    );
  } catch (error) {
    return [/** @type {Error} */ (error), null];
  }

  try {
    data = await response.json();
  } catch (error) {
    return [/** @type {Error} */ (error), null];
  }

  try {
    response = await fetch(
      `${SPOTIFY_URL_DOMAIN}v1/playlists/${/** @type {{ id: string }} */ (data).id}/tracks`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${bearer}`,
        },
        body: jsonifiedUriList,
        mode: "cors",
      },
    );
  } catch (error) {
    return [/** @type {Error} */ (error), null];
  }

  if (response.status > 399) {
    const data = await response.text();
    return [new Error(data), null];
  }

  try {
    data = await response.json();
  } catch (error) {
    return [/** @type {Error} */ (error), null];
  }

  return [null, data];
};
