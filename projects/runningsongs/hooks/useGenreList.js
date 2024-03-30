import { useEffect, useState, useRef } from "preact/hooks";
import { getter as getGenreSeeds } from "../endpoint-types/available-genre-seeds.js";

/**
 * @typedef {import("../endpoint-types/available-genre-seeds.js").Response} GenreSeedData
 * @typedef {import("../endpoint-types/available-genre-seeds.js").GenreList} GenreList
 *
 * @typedef {{ result: GenreList | null, error: Error | null, isFetching: boolean, tooManyTries: boolean }} State
 **/

const ATTEMPT_COUNT_LIMIT = 3;

export function useGenreList() {
  const attemptCount = useRef(0);
  const [{ isFetching, result: genreList, error, tooManyTries }, setRequest] =
    useState(
      /** @type {State} */ ({
        result: null,
        error: null,
        isFetching: false,
        tooManyTries: attemptCount.current >= ATTEMPT_COUNT_LIMIT,
      }),
    );

  useEffect(
    function getGenreData() {
      if (isFetching || genreList || tooManyTries) {
        return;
      }

      setRequest({
        result: genreList,
        error,
        isFetching: true,
        tooManyTries: attemptCount.current >= ATTEMPT_COUNT_LIMIT,
      });

      getGenreSeeds().then((response) => {
        const [error, result] = response;
        attemptCount.current += 1;

        if (error) {
          setRequest({
            error,
            result: null,
            isFetching: false,
            tooManyTries: attemptCount.current >= ATTEMPT_COUNT_LIMIT,
          });
          return;
        } else {
          setRequest({
            error: null,
            result: result.genres,
            isFetching: false,
            tooManyTries: attemptCount.current >= ATTEMPT_COUNT_LIMIT,
          });
        }
      });
    },
    [error, genreList, isFetching, tooManyTries],
  );

  return {
    genreList,
    error,
    isFetching,
  };
}
