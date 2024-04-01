import { getFromSpotify } from "../helpers/getFromSpotify.js";

/**
 * @typedef {string} Genre
 * @typedef {Genre[]} GenreList
 * @typedef {{ genres: GenreList }} Data
 * @typedef {[Error, null] | [null, Data]} Response
 */

export const url = "recommendations/available-genre-seeds";

export const getter = () =>
  /** @type {Promise<Response>} */ (getFromSpotify(url));
