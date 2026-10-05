// Get comments
const COMMENT_API_BASE_URL = "https://comment-cdn.9gag.com/";
const COMMENT_LIST_PATH = "v1/cacheable/comment-list.json";
const COMMENT_LIST_BASE_PARAMS = [
  "appId=a_dd8f2b7d304a10edaf6f29517ea0ca4100a43d1b",
  "count=10000",
  "order=score",
  "origin=https:%2F%2F9gag.com",
];

const parserElt = document.createElement("div");
function parseComment(comment) {
  parserElt.innerHTML = comment;
  return parserElt.textContent;
}

function getPostCommentsURL(postId) {
  return `${COMMENT_API_BASE_URL}${COMMENT_LIST_PATH}?${COMMENT_LIST_BASE_PARAMS.join("&")
    }&url=${encodeURIComponent('https://9gag.com/gag/')}${postId}`;
}

function getPostCommentRepliessURL(postId, commentId) {
  return `${getPostCommentsURL(postId)
    }&refCommentId=${commentId}`;
}

async function getPostComments(postId) {
  let response = await fetch(getPostCommentsURL(postId));
  let payload = await response.json();
  return payload.payload;
}

async function getPostCommentReplies(postId, commentId) {
  let response = await fetch(getPostCommentRepliessURL(postId, commentId));
  let payload = await response.json();
  return payload.payload;
}


// Get posts
const BASE_POSTS_URL = "https://9gag.com/";
const POSTS_PATH = "v1/group-posts/group/default/type/hot";
const POSTS_BASE_PARAMS = ["c=10"];

function getPostsURL(nextCursor = "") {
  let query = POSTS_BASE_PARAMS.join("&");
  if (nextCursor) {
    query += `&${nextCursor}`
  }
  return `${BASE_POSTS_URL}${POSTS_PATH}?${query}`;
}

const foundPosts = [];
let nextCursor = "";

async function getPosts({ postCount = 100 } = {}) {
  while (foundPosts.length < postCount) {
    let response = await fetch(getPostsURL(nextCursor));
    let payload = await response.json();
    let posts = await Promise.all(payload.data.posts.map(async post => {
      let comments = (await getPostComments(post.id)).comments;
      console.log(`Got comments for post: ${post.id}`);

      let commentsWithReplies = await Promise.all(comments.map(async comment => {
        let replies = comment.hasNext
          ? (await getPostCommentReplies(post.id, comment.commentId)).comments.map(reply => ({
            id: reply.commentId,
            text: parseComment(parseComment(reply.richtext)),
            hasNext: reply.hasNext,
            likeCount: reply.likeCount,
            dislikeCount: reply.dislikeCount,
            rating: reply.likeCount - reply.dislikeCount,

            replies: reply.children.map(replyReply => ({
              id: replyReply.commentId,
              text: parseComment(parseComment(replyReply.richtext)),
              hasNext: replyReply.hasNext,
              likeCount: replyReply.likeCount,
              dislikeCount: replyReply.dislikeCount,
              rating: replyReply.likeCount - replyReply.dislikeCount,
            })),
          }))
          : [];
        if (replies.length) {
          console.log(`Got replies for comment: ${comment.commentId}`);
        }

        return {
          id: comment.commentId,
          text: parseComment(parseComment(comment.richtext)),
          hasNext: comment.hasNext,
          likeCount: comment.likeCount,
          dislikeCount: comment.dislikeCount,
          rating: comment.likeCount - comment.dislikeCount,
          replies,
        }
      }));

      return {
        id: post.id,
        title: post.title,
        promoted: !!post.promoted,
        upVoteCount: post.upVoteCount,
        downVoteCount: post.downVoteCount,
        rating: post.upVoteCount - post.downVoteCount,
        comments: commentsWithReplies,
      };
    }));
    nextCursor = payload.data.nextCursor;
    foundPosts.push(
      ...posts
        .filter(post => !post.promoted && !foundPosts.find(foundPost => foundPost.id === post.id))
        .map(post =>
          ({
            id: post.id,
            title: post.title,
            rating: post.rating,
            comments: post.comments,
          })
        )
    );
    console.log(`New useful post count: ${foundPosts.length}`);
  }
  return foundPosts;
};
