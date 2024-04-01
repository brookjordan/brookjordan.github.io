import { useEffect, useState, useRef } from "preact/hooks";

/**
 * @typedef {import("../endpoint-types/available-genre-seeds.js").Response} GenreSeedData
 * @typedef {import("../endpoint-types/available-genre-seeds.js").GenreList} GenreList
 *
 * @typedef {{ result: GenreList | null, error: Error | null, isFetching: boolean, tooManyTries: boolean }} State
 **/

export function useGenreList() {
  return {
    hello: "bye",
  };
}
