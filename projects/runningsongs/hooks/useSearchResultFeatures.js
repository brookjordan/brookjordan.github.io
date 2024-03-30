import { useEffect, useState, useCallback, useMemo } from "preact/hooks";
import { getter as getSearchedTracks } from "../endpoint-types/search.js";
import { getter as getTrackFeatures } from "../endpoint-types/recommendations_audio-features.js";

/**
 * @typedef {import("../endpoint-types/search.js").TrackPage} TrackPage
 * @typedef {import("../endpoint-types/search.js").Response} TrackResponse
 * @typedef {import("../endpoint-types/recommendations_audio-features.js").Response} TrackFeaturesResponse
 *
 * @typedef {TrackPage[]} TrackPages
 * @typedef {{ isNew: boolean, searchTerm: string | null | undefined, genre: string | null | undefined, next: string | null, pages: TrackPages | null, error: Error | null, isFetching: boolean }} State
 **/

/**
 *
 * @param {Object} params
 * @param {string | null | undefined} params.searchTerm
 * @param {string | null | undefined} params.genre
 */
export function useSearchResultFeatures({
  searchTerm: searchTermProps,
  genre: genreProps,
}) {
  const isDifferentSearch = useCallback(
    /**
     * @param {State['genre']} checkingGenre
     * @param {State['searchTerm']} checkingSearchTerm
     */
    (checkingGenre, checkingSearchTerm) =>
      checkingGenre !== genreProps || checkingSearchTerm !== searchTermProps,
    [genreProps, searchTermProps],
  );

  const [
    { isNew, genre, searchTerm, next, isFetching, pages: trackLists, error },
    setState,
  ] = useState(
    /** @type {State} */ ({
      isNew: true,
      searchTerm: searchTermProps,
      genre: genreProps,
      next: null,
      pages: null,
      error: null,
      isFetching: false,
    }),
  );

  useEffect(
    function getGenreData() {
      if (isDifferentSearch(genre, searchTerm)) {
        setState({
          isNew: true,
          searchTerm: searchTermProps,
          genre: genreProps,
          pages: null,
          error,
          isFetching: false,
          next: null,
        });
        return;
      } else if (!isNew && (isFetching || !next || error)) {
        return;
      }

      const searchQuery =
        (!isNew && next) ||
        (() => {
          const searchQuery = [];

          if (searchTermProps) {
            searchQuery.push(encodeURIComponent(searchTermProps));
          }

          if (genreProps) {
            searchQuery.push(`genre:${genreProps}`);
          }

          if (!searchQuery.length) return;

          return `type=track&limit=50&q=${searchQuery.join(" ")}`;
        })();

      if (!searchQuery) return;

      /**
       * @param {TrackResponse} response
       * @return {[Error, null] | Promise<TrackFeaturesResponse>}
       */
      const getFeaturesFromResponse = (response) => {
        const [error, result] = response;

        if (error) {
          setState((oldRequest) =>
            isDifferentSearch(oldRequest.genre, oldRequest.searchTerm)
              ? oldRequest
              : {
                  ...oldRequest,
                  isNew: false,
                  error,
                  pages: null,
                  isFetching: false,
                },
          );
          return [error, null];
        }

        setState((oldRequest) =>
          isDifferentSearch(oldRequest.genre, oldRequest.searchTerm)
            ? oldRequest
            : {
                ...oldRequest,
                isNew: false,
                next: result.tracks.next,
                pages: oldRequest.pages
                  ? [...oldRequest.pages, result.tracks.items]
                  : [result.tracks.items],
                isFetching: true,
              },
        );

        return getTrackFeatures(
          result.tracks.items.flatMap((track) => {
            if (!track?.id) {
              console.warn("A track was invalid and so didn’t get features");
            }

            return track.id;
          }),
        );
      };

      getSearchedTracks(searchQuery)
        .then(getFeaturesFromResponse)
        .then((response) => {
          const [error, result] = response;

          if (error) {
            setState((oldRequest) =>
              isDifferentSearch(oldRequest.genre, oldRequest.searchTerm)
                ? oldRequest
                : {
                    ...oldRequest,
                    isNew: false,
                    error,
                    pages: null,
                    isFetching: false,
                  },
            );
            return [error, null];
          }

          setState((oldRequest) => {
            if (isDifferentSearch(oldRequest.genre, oldRequest.searchTerm)) {
              return oldRequest;
            }

            return {
              ...oldRequest,
              isNew: false,
              pages:
                oldRequest.pages?.map((page) =>
                  page.map((track) => ({
                    ...track,
                    meta:
                      track.meta ??
                      result.audio_features.find(
                        (feature) => feature.id === track.id,
                      ),
                  })),
                ) ?? null,
              isFetching: false,
            };
          });
        });
    },
    [
      error,
      genre,
      genreProps,
      isDifferentSearch,
      isFetching,
      isNew,
      next,
      searchTerm,
      searchTermProps,
    ],
  );

  const trackList = useMemo(
    () => trackLists && trackLists.flat(),
    [trackLists],
  );

  return {
    trackList,
    error,
    isFetching,
  };
}
