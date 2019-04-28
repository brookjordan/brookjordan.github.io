let searchParams = getParams();

function getParams() {
  return [...(new URLSearchParams(location.search)).entries()]
    .reduce((obj, param) => {
      obj[param[0]] = param[1];
      return obj;
    }, {});
}
