import { html } from "../helpers/html.js";
import RedirectToAuth from "../components/RedirectToAuth.js";
import GenreList from "../components/GenreList.js";
import TextInput from "../components/TextInput.js";
import SongsInSearchWithinTempo, {
  DEFAULT_TEMPO,
  DEFAULT_TEMPO_ACCURACY,
} from "../components/SongsInSearchWithinTempo.js";
import UserDetails from "../components/UserDetails.js";
import { useState } from "preact/hooks";
import { bearer } from "../helpers/bearer.js";
import { useGenreList } from "../hooks/useGenreList.js";
import { useUser } from "../hooks/useUser.js";
import { useSearchResultFeatures } from "../hooks/useSearchResultFeatures.js";
import NumberInput from "../components/NumberInput.js";
import { sendPlaylistToSpotify } from "../helpers/sendPlaylistToSpotify.js";

/**
 * @typedef {import("endpoint-types/search.js").Track} Track
 */

function App() {
  const [isSavingPlaylist, setIsSavingPlaylist] = useState(false);
  const [playlistName, setPlaylistName] = useState("");
  const [searchTerm, setSearchTerm] = useState("");
  const [targetTempo, setTargetTempo] = useState(DEFAULT_TEMPO);
  const [tempoAccuracy, setTempoAccuracy] = useState(DEFAULT_TEMPO_ACCURACY);
  const [genre, setGenre] = useState(/** @type {string | null} */ (null));
  const [selectedTracks, setSelectedTracks] = useState(
    /** @type {Track[]} */ ([]),
  );

  const {
    genreList,
    isFetching: isFetchingGenreList,
    error: genreListError,
  } = useGenreList();
  const { user, isFetching: isFetchingUser, error: userError } = useUser();
  const errors = [genreListError, userError].filter(Boolean);
  const loadingItems = [
    isFetchingGenreList && "genres",
    isFetchingUser && "user",
  ].filter(Boolean);

  const { trackList, isFetching: isFetchingtracks } = useSearchResultFeatures({
    genre,
    searchTerm,
  });

  const cannotSubmitReason = isSavingPlaylist
    ? "Saving, hold on…"
    : !user
      ? "Loading user, hold on…"
      : !playlistName
        ? "Pick a playlist name first"
        : playlistName.length < 5
          ? "Playlist name needs to be longer"
          : selectedTracks.length < 5
            ? "Playlist needs more tracks"
            : undefined;

  /**
   * @param {Event} event
   */
  const handleSubmit = async (event) => {
    event.preventDefault();

    if (cannotSubmitReason) {
      alert(cannotSubmitReason);
      return;
    }

    if (!user) return;

    setIsSavingPlaylist(true);

    try {
      const [error] = await sendPlaylistToSpotify(
        user.id,
        playlistName,
        selectedTracks.map((track) => track.id),
      );

      if (error) {
        alert(`Something went wrong saving the playlist: ${error.message}`);
        console.log(error);
        return;
      }

      alert("Playlist was saved!");
    } catch (error) {
      alert(
        `Something went wrong saving the playlist: ${/** @type {Error} */ (error).message}`,
      );
      console.log(error);
    } finally {
      setIsSavingPlaylist(false);
    }
  };

  return errors.some((error) => error?.message === "Too many requests")
    ? html`<p>We’ve been locked out for making too many requests</p>`
    : errors.length || !bearer
      ? html`<div>
          <p>Redirecting to login…</p>
          <${RedirectToAuth} clientId="482a3678373843f3b55dc3e41a59f639" />
        </div>`
      : loadingItems.length
        ? html`<p>Loading ${loadingItems.join(", ")}…</p>`
        : html`<form onSubmit=${handleSubmit} class="app-form">
            <h1>Runnin’ tunes</h1>
            <${UserDetails} user=${user} />

            <menu>
              <${TextInput}
                label="Playlist name"
                placeholder="My great playlist"
                value=${playlistName}
                onInput=${setPlaylistName}
              />

              <button disabled=${!!cannotSubmitReason}>Create playlist</button>
            </menu>

            <aside>
              <menu>
                <${TextInput}
                  type="search"
                  label="Search"
                  placeholder="Search for a song"
                  value=${searchTerm}
                  onInput=${setSearchTerm}
                />

                <${NumberInput}
                  label="Tempo"
                  placeholder="170"
                  value=${targetTempo}
                  onInput=${setTargetTempo}
                />

                <${NumberInput}
                  label="Range"
                  placeholder="0.02"
                  value=${tempoAccuracy}
                  onInput=${setTempoAccuracy}
                />
              </menu>

              <h3>Filter by genre</h3>
              <${GenreList}
                genreList=${genreList}
                value=${genre}
                onChange=${setGenre}
              />
            </aside>

            <section>
              <h3>Found songs</h3>
              <${SongsInSearchWithinTempo}
                searchTerm=${searchTerm}
                genre=${genre}
                tempo=${targetTempo}
                accuracy=${tempoAccuracy}
                trackList=${trackList}
                isFetching=${isFetchingtracks}
                selectedTracks=${selectedTracks}
                onSelectedTrackChange=${setSelectedTracks}
              />
            </section>
          </form>`;
}

export default App;
