export const bearer =
  new URLSearchParams(location.hash?.slice(1)).get("access_token") || null;
