import {
  SPOTIFY_URL_DOMAIN,
  getFromSpotify,
} from "../helpers/getFromSpotify.js";

/**
 * @typedef {{ name: string }} Album
 * @typedef {{ tempo: number }} Meta
 * @typedef {{ id: string, name: string, album: Album, meta?: Meta }} Track
 * @typedef {Track[]} TrackPage
 * @typedef {{ tracks: { items: TrackPage, next: string | null } }} TrackData
 * @typedef {[Error, null] | [null, TrackData]} Response
 **/

export const url = "search";

/**
 * @param {string} query
 */
export const getter = (query) => /** @type {Promise<Response>} */ {
  return /** @type {Promise<Response>} */ (
    query.startsWith(SPOTIFY_URL_DOMAIN)
      ? getFromSpotify(query)
      : getFromSpotify(`${url}?${query}`)
  );
};
