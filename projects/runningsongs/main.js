const clientSecret = "f5cb698f8fcc4568bb430938a93bf2a5";
const clientId = "482a3678373843f3b55dc3e41a59f639";
const RADIOHEAD_ID = "4Z8W4fKeB5YxbusRsdQVPb";
let bearer;
let userId;
let playlistId;

async function redirectToAuthCodeFlow(clientId) {
  const verifier = generateCodeVerifier(128);
  const challenge = await generateCodeChallenge(verifier);

  localStorage.setItem("verifier", verifier);

  const params = new URLSearchParams();
  params.append("client_id", clientId);
  params.append("response_type", "token");
  params.append("redirect_uri", "https://brook.dev/projects/runningsongs");
  params.append("scope", "user-read-private user-read-email");
  params.append("code_challenge_method", "S256");
  params.append("code_challenge", challenge);
  params.append(
    "scope",
    ["playlist-modify-public", "playlist-modify-private"].join(" ")
  );
  document.location = `https://accounts.spotify.com/authorize?${params.toString()}`;
}

function generateCodeVerifier(length) {
  let text = "";
  let possible =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for (let i = 0; i < length; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  return text;
}

async function generateCodeChallenge(codeVerifier) {
  const data = new TextEncoder().encode(codeVerifier);
  const digest = await window.crypto.subtle.digest("SHA-256", data);
  return btoa(String.fromCharCode.apply(null, [...new Uint8Array(digest)]))
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/, "");
}

async function getAccessToken(clientId, code) {
  const verifier = localStorage.getItem("verifier");

  const params = new URLSearchParams();
  params.append("client_id", clientId);
  params.append("grant_type", "authorization_code");
  params.append("token", code);
  params.append("redirect_uri", "https://brook.dev/projects/runningsongs");
  params.append("code_verifier", verifier);

  const result = await fetch("https://accounts.spotify.com/api/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: params,
  });

  const { access_token } = await result.json();
  return access_token;
}

async function getData(endPoint) {
  try {
    const response = await fetch(
      `https://api.spotify.com/v1/${endPoint.replace(/^\//, "")}`,
      {
        headers: {
          Authorization: `Bearer ${bearer}`,
        },
      }
    );
    return [null, await response.json()];
  } catch (error) {
    return [error, null];
  }
}
window.getData = getData;

const appendGenres = () => {
  getData("recommendations/available-genre-seeds").then(
    ([error, { genres }]) => {
      const checkList = document.createDocumentFragment();

      genres.forEach((genre) => {
        const id = `genre__${genre}`;

        const input = document.createElement("input");
        input.setAttribute("for", id);
        input.setAttribute("type", "radio");
        input.setAttribute("name", "genres");
        input.setAttribute("value", genre);

        const label = document.createElement("label");
        label.style.display = "inline-flex";
        label.setAttribute("id", id);
        label.textContent = genre;
        label.prepend(input);

        checkList.append(label);
      });

      const input = document.createElement("input");
      input.setAttribute("placeholder", "Playlist name");

      const button = document.createElement("button");
      button.textContent = "Make playlist";
      button.addEventListener("click", async () => {
        if (!input.value) return;

        button.setAttribute("disabled", "disabled");
        button.textContent = `Creating playlist: Run: ${input.value}`;

        const response = await fetch(
          `https://api.spotify.com/v1/users/${userId}/playlists`,
          {
            method: "POST",
            body: JSON.stringify({ name: `Run: ${input.value}` }),
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${bearer}`,
            },
            mode: "cors",
          }
        );

        button.textContent = "Playlist created!";

        const data = await response.json();

        playlistId = data.id;
        window.playlistId = playlistId;
      });

      document.body.append(
        input,
        document.createElement("hr"),
        button,
        document.createElement("hr"),
        checkList
      );
    }
  );
};
window.appendGenres = appendGenres;

const getCheckedRadioValue = (radioName) =>
  document.querySelector(`input[type="radio"][name="${radioName}"]:checked`)
    ?.value;

const getCheckedGenre = () => getCheckedRadioValue("genres");

const getUserId = () => {
  getData("me").then(([error, data]) => {
    if (error) {
      console.error(error);
      return;
    }
    userId = data.id;
    window.userId = userId;
  });
};

const pageSize = 50;
const wantedTempo = 170;
const tempoAccuracy = 10;
const minTempo = wantedTempo - tempoAccuracy;
const maxTempo = wantedTempo + tempoAccuracy;
const getTrackFeaturesFromGenre = async (count = 10) => {
  const genre = getCheckedGenre();

  if (!genre) {
    console.error("No genres selected");
    return;
  }

  let matchingTracks = [];
  let offset = 0;

  while (matchingTracks.length < count) {
    if (offset * pageSize >= 1000) {
      console.log("Reached the end of the search results.");
      break;
    }

    const [tracksError, { tracks }] = await getData(
      `search?q=genre:${genre}&type=track&limit=${pageSize}&offset=${
        offset * pageSize
      }`
    );

    if (tracksError) {
      console.log("Error fetching tracks");
      console.error(tracksError);
      break;
    }

    if (!tracks || !tracks.items || !tracks.items.length) {
      console.log("No more tracks found.");
      break;
    }

    const [featuresError, { audio_features }] = await getData(
      `audio-features?ids=${tracks.items.map((track) => track.id)}`
    );

    if (featuresError) {
      console.error("Error fetching track features");
      console.error(featuresError);
      break;
    }

    matchingTracks.push(
      ...audio_features
        .filter((feature) => feature)
        .map((features, i) => [
          tracks.items[i].id,
          tracks.items[i].name,
          tracks.items[i].artists.map((artist) => artist.name).join("; "),
          features.tempo,
          features.danceability,
        ])
        .filter(
          ([id, name, artists, tempo, danceability], index, arr) =>
            ((tempo >= minTempo * 2 && tempo <= maxTempo * 2) ||
              (tempo >= minTempo && tempo <= maxTempo) ||
              (tempo >= minTempo / 2 && tempo <= maxTempo / 2)) &&
            danceability > 0.5
        )
    );

    matchingTracks = matchingTracks.filter(
      ([id], index, arr) => arr.findIndex(([idB]) => idB === id) === index
    );

    offset += 1;
  }

  console.log({ matchingTracks });

  fetch(`https://api.spotify.com/v1/playlists/${playlistId}/tracks`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${bearer}`,
    },
    body: JSON.stringify({
      uris: matchingTracks.map(([trackId]) => `spotify:track:${trackId}`),
    }),
    mode: "cors",
  });

  return matchingTracks;
};
window.getTrackFeaturesFromGenres = getTrackFeaturesFromGenre;

bearer = new URLSearchParams(location.hash?.slice(1)).get("access_token");
if (bearer) {
  // history.replaceState(null, null, location.href.split("?")[0].split("#")[0]);
  document.body.innerHTML = "Loading profile...";

  window.bearer = bearer;
  document.body.innerHTML = "You are now logged in!. Loading a test…";

  document.body.innerHTML = "";
  appendGenres();
  getUserId();
} else {
  document.body.innerHTML = "Logging in...";

  redirectToAuthCodeFlow(clientId);
}
