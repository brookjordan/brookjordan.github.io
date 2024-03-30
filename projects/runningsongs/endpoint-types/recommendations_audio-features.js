import { getFromSpotify } from "../helpers/getFromSpotify.js";

/**
 * @typedef {{ id: string, tempo: number }} TrackFeature
 * @typedef {{ audio_features: TrackFeature[] }} TrackFeaturesData
 * @typedef {[Error, null] | [null, TrackFeaturesData]} Response
 */

export const url = "audio-features";

/**
 * @param {string[]} trackIds
 */
export const getter = (trackIds) =>
  /** @type {Promise<Response>} */ (getFromSpotify(`${url}?ids=${trackIds}`));
