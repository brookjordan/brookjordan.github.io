let cachedList = JSON.parse(localStorage.getItem("stunList") || "null");
let asyncStunList = null;

const getPublicStunServerListFromServer = async () => {
  const stunListPromise =
    asyncStunList ||
    fetch(
      "https://raw.githubusercontent.com/pradt2/always-online-stun/master/valid_hosts.txt"
    )
      .then((response) => response.text())
      .catch(() => {
        asyncStunList = null;
        return null;
      });

  return (await stunListPromise)?.split("\n");
};

const getPublicStunServerList = async () => {
  if (
    cachedList &&
    Date.now() - new Date(cachedList.dateAdded).getTime() < 10 * 60 * 1000
  ) {
    return cachedList.urls;
  }

  return getPublicStunServerListFromServer().then((urls) => {
    localStorage.setItem(
      "stunList",
      JSON.stringify({
        dateAdded: new Date(),
        urls,
      })
    );
    return urls;
  });
};

const getRandomStunServer = async () => {
  let servers = await getPublicStunServerList();

  return servers[Math.floor(Math.random() * servers.length)] || null;
};

const getStunServers = async ({ searchParam, serverCount = 3 } = {}) => {
  let cachedStunServers = searchParam
    ? new URLSearchParams(location.search).get(searchParam)
    : null;

  if (!cachedStunServers) {
    const newStunServers = await Promise.all(
      Array.from({ length: serverCount }, () => getRandomStunServer())
    );

    if (searchParam) {
      let encodedServer = btoa(newStunServers);
      let newURL = new URL(location);
      let uRLSearch = new URLSearchParams(location.search);
      uRLSearch.set(searchParam, encodedServer);
      newURL.search = uRLSearch;
      history.replaceState(null, "", newURL.toString());
    }

    return newStunServers;
  }

  return atob(cachedStunServers).split(",");
};

getStunServers({ searchParam: "stunServers", serverCount: 1 }).then((serverUrls) => {
  if (globalThis.buttoncreateoffer?.style.opacity) {
    buttoncreateoffer.style.opacity = 1;
  }
  if (globalThis.buttonofferpasted?.style.opacity) {
    buttonofferpasted.style.opacity = 1;
  }
  globalThis.stunServerUrls = serverUrls;
});
