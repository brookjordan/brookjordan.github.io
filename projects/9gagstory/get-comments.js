const COMMENT_API_BASE_URL = "https://comment-cdn.9gag.com/";
const COMMENT_LIST_PATH = "v1/cacheable/comment-list.json";
const COMMENT_LIST_BASE_PARAMS = [
  "appId=a_dd8f2b7d304a10edaf6f29517ea0ca4100a43d1b",
  "count=10000",
  "order=score",
  "origin=https:%2F%2F9gag.com",
];

function getPostCommentsURL(postId) {
  return `${COMMENT_API_BASE_URL}${COMMENT_LIST_PATH}?${COMMENT_LIST_BASE_PARAMS.join("&")
    }&url=${encodeURIComponent('https://9gag.com/gag/')}${postId}`;
}

function getPostCommentRepliessURL(postId, commentId) {
  return `${getPostCommentsURL(postId)
    }&refCommentId=${commentId}`;
}

export async function getPostComments(postId) {
  let response = await fetch(getPostCommentsURL(postId));
  let payload = await response.json();
  return payload.payload;
}

export async function getPostCommentReplies(postId, commentId) {
  let response = await fetch(getPostCommentRepliessURL(postId, commentId));
  let payload = await response.json();
  return payload.payload;
}
