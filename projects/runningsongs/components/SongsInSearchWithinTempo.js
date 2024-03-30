import { isHTMLInputElement } from "../helpers/isHTMLInputElement.js";
import { html } from "../helpers/html.js";
import { useMemo, useCallback, useEffect } from "preact/hooks";

/**
 * @typedef {import("../endpoint-types/search.js").Track} Track
 *
 * @typedef {'full' | 'half' | 'double'} Speed
 **/

export const DEFAULT_TEMPO = 170;
export const DEFAULT_TEMPO_ACCURACY = 0.01;

/** @type {Track[]} */
const defaultTrackList = [];

/**
 * @param {Object} params
 * @param {string} params.searchTerm
 * @param {string} params.genre
 * @param {Track[] | undefined} params.trackList
 * @param {Track[] | undefined} params.selectedTracks
 * @param {(tracks: Track[]) => void} params.onSelectedTrackChange
 * @param {boolean} params.isFetching
 * @param {number} params.accuracy
 * @param {number} params.tempo
 */
function SongsInSearchWithinTempo({
  searchTerm,
  genre,
  trackList: trackListProps,
  selectedTracks: selectedTracksProps,
  onSelectedTrackChange,
  isFetching,
  tempo = DEFAULT_TEMPO,
  accuracy = DEFAULT_TEMPO_ACCURACY,
}) {
  const tempos = useMemo(
    () =>
      /** @type {{ name: "full" | "half" | "double", value: number, min: number, max: number }[]} */ ([
        {
          name: "full",
          value: tempo,
          min: tempo * (1 - accuracy),
          max: tempo * (1 + accuracy),
        },
        {
          name: "half",
          value: tempo / 2,
          min: (tempo / 2) * (1 - accuracy),
          max: (tempo / 2) * (1 + accuracy),
        },
        {
          name: "double",
          value: tempo * 2,
          min: tempo * 2 * (1 - accuracy),
          max: tempo * 2 * (1 + accuracy),
        },
      ]),
    [accuracy, tempo],
  );
  console.log(tempos)

  const trackList = trackListProps ?? defaultTrackList;
  const selectedTracks = selectedTracksProps ?? defaultTrackList;

  /**
   * @param {Track} track
   */
  const handleTrackToggle =
    (track) =>
    /**
     * @param {Event} event
     */
    (event) => {
      event.preventDefault();

      const currentTarget = event.currentTarget;
      if (!isHTMLInputElement(currentTarget)) return;

      onSelectedTrackChange(
        currentTarget.checked
          ? [...selectedTracks, track]
          : selectedTracks.filter((trackB) => trackB.id !== track.id),
      );
    };

  const tempoSpeed = useCallback(
    /**
     * @param {number | undefined} requiredTempo
     *
     * @returns {"full" | "half" | "double" | null}
     */ (requiredTempo) => {
      if (!requiredTempo) {
        return null;
      }

      for (let i = 0; i < tempos.length; i++) {
        if (requiredTempo > tempos[i].min && requiredTempo < tempos[i].max) {
          return tempos[i].name;
        }
      }

      return null;
    },
    [tempos],
  );

  const tracksToShow = useMemo(
    () =>
      [
        ...(selectedTracks ?? []).filter((selectedTrack) => {
          // don’t show selected tracks that are in the sarch results
          if (!trackList.every((track) => track.id !== selectedTrack.id)) {
            return false;
          }

          return true;
        }),
        ...(trackList ?? []),
      ].flatMap((track, trackIndex, allTracks) => {
        if (!track?.meta) {
          return [];
        }

        // don’t show repeats
        if (
          allTracks.findIndex((trackB) => trackB.id === track.id) !== trackIndex
        ) {
          return [];
        }

        const pacing = tempoSpeed(track.meta.tempo);
        if (!pacing) {
          return [];
        }

        return { ...track, meta: { ...track.meta, pacing } };
      }),
    [selectedTracks, tempoSpeed, trackList],
  );

  useEffect(
    function removeTracksNotWithinTempoRange() {
      if (
        selectedTracks.every(
          (track) => track.meta && tempoSpeed(track.meta.tempo),
        )
      ) {
        return;
      }

      onSelectedTrackChange(
        selectedTracks.flatMap((track) => {
          if (!track.meta || !tempoSpeed(track.meta.tempo)) {
            return [];
          }

          return track;
        }),
      );
    },

    [onSelectedTrackChange, selectedTracks, tempoSpeed],
  );

  return html`<div class="songs-in-search">
    <p>${searchTerm}</p>
    <p>${genre}</p>
    ${tracksToShow.length
      ? tracksToShow.map((track) => {
          const displayTempo = track.meta ? Math.round(track.meta.tempo) : "—";
          const displayModifiedTempo = !track.meta.tempo
            ? null
            : track?.meta?.pacing === "half"
              ? Math.round(track.meta.tempo * 2)
              : track?.meta?.pacing === "double"
                ? Math.round(track.meta.tempo / 2)
                : null;
          const displayAlbumName = track.album.name
            ? html`<sub> — ${track.album.name}</sub>`
            : "";

          return html`<ul>
            ${html`<li>
              <label>
                <sub
                  >tempo:
                  ${displayTempo}${displayModifiedTempo
                    ? ` (${displayModifiedTempo})`
                    : ""}</sub
                >
                <span> ${track.name}${displayAlbumName} </span>

                <input
                  type="checkbox"
                  checked=${selectedTracks.some(
                    (trackB) => trackB.id === track.id,
                  )}
                  onChange=${handleTrackToggle(track)}
                />
              </label>
            </li>`}
          </ul>`;
        })
      : html`<p>No tracks found</p>`}
    ${isFetching && html`<p>Loading tracks…</p>`}
  </div>`;
}

export default SongsInSearchWithinTempo;
