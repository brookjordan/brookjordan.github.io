import { bearer } from "../helpers/bearer.js";

export const SPOTIFY_URL_DOMAIN = "https://api.spotify.com/";
let successfulRequestCount = 0;

/**
 * @param {string} endPoint
 * @returns {Promise<[Error, null] | [null, unknown]>}
 */
export async function getFromSpotify(endPoint) {
  try {
    const response = await fetch(
      endPoint.startsWith(SPOTIFY_URL_DOMAIN)
        ? endPoint
        : `${SPOTIFY_URL_DOMAIN}v1/${endPoint.replace(/^\//, "")}`,
      {
        headers: {
          Authorization: `Bearer ${bearer}`,
        },
      },
    );

    if (response.status > 399) {
      const data = await response.text();
      let json;
      try {
        json = JSON.parse(data);
      } catch (error) {}

      if (
        response.status === 401 &&
        json?.error.message === "The access token expired"
      ) {
        if (successfulRequestCount) {
          alert(
            "Sorry, you took too long, we need to refresh the page and reauthenticate.",
          );
          location.reload();
        }
      }

      return [new Error(json || data), null];
    }

    successfulRequestCount += 1;
    return [null, await response.json()];
  } catch (error) {
    return [/** @type {Error} */ (error), null];
  }
}
