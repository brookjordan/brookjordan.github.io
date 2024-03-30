import { useEffect, useState } from "preact/hooks";
import { getter as getUser } from "../endpoint-types/me.js";

/**
 * @typedef {import("../endpoint-types/me.js").Response} UserResponse
 * @typedef {import("../endpoint-types/me.js").User} User
 *
 * @typedef {{ isFetching: boolean, result: User | null, error: Error | null }} State
 **/

export function useUser() {
  const [{ isFetching, result: user, error }, setRequest] = useState(
    /** @type {State} */ ({
      result: null,
      error: null,
      isFetching: false,
    }),
  );

  useEffect(
    function getGenreData() {
      if (isFetching || user) {
        return;
      }

      setRequest({
        result: user,
        error,
        isFetching: true,
      });

      getUser().then((response) => {
        const [error, newUser] = response;

        if (error) {
          setRequest({
            result: null,
            error,
            isFetching: false,
          });
          return;
        } else {
          setRequest({
            result: newUser,
            error: null,
            isFetching: false,
          });
        }
      });
    },
    [error, isFetching, user],
  );

  return {
    user,
    error,
    isFetching,
  };
}
