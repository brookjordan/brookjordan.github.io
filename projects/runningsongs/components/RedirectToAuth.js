import { generateCodeChallenge } from "../helpers/generateCodeChallenge.js";
import { generateCodeVerifier } from "../helpers/generateCodeVerifier.js";
import { useEffect } from "preact/hooks";

/**
 * @param {Object} params
 * @param {string} params.clientId
 */
function RedirectToAuth({ clientId }) {
  useEffect(() => {
    const verifier = generateCodeVerifier(0b10000000);

    generateCodeChallenge(verifier).then((challenge) => {
      localStorage.setItem("verifier", verifier);

      const params = new URLSearchParams();
      params.append("client_id", clientId);
      params.append("response_type", "token");
      params.append(
        "redirect_uri",
        location.href.includes("brook.dev") ? "https://brook.dev/projects/runningsongs"
          : "http://127.0.0.1:8080",
      );
      params.append("scope", "user-read-private user-read-email");
      params.append("code_challenge_method", "S256");
      params.append("code_challenge", challenge);
      params.append(
        "scope",
        ["playlist-modify-public", "playlist-modify-private"].join(" "),
      );
      document.location = `https://accounts.spotify.com/authorize?${params.toString()}`;
    });
  }, [clientId]);
}

export default RedirectToAuth;
