import { getFromSpotify } from "../helpers/getFromSpotify.js";

/**
 * @typedef {{ spotify: string | undefined }} ExternalURLs
 * @typedef {{ id: string, display_name: string, external_urls: ExternalURLs }} User
 * @typedef {[Error, null] | [null, User]} Response
 */

export const url = "me";

export const getter = () =>
  /** @type {Promise<Response>} */ (getFromSpotify(`${url}`));
