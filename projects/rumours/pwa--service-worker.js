self.importScripts("./pwa--cache-details.js");

self.addEventListener("install", event => {
  let preCache = async () => {
    const cache = await caches.open(cacheName);
    await cache.addAll(staticAssets);
  };
  event.waitUntil(preCache());
});

async function getStreamData(stream) {
  let reader;

  try {
    let data = new Uint8Array();
    if (!stream) { return null; }
    reader = stream.getReader();
    if (!reader || !reader.read) { return null; }
    let done;
    let value;
    do {
      ({ done, value } = await reader.read());
      if (value) {
        let newData = new Uint8Array(data.length + value.length);
        newData.set(data);
        newData.set(value, data.length);
        data = newData;
      }
    } while (!done);
    return data;
  } catch (error) {
    console.log(error);
  } finally {
    reader && reader.releaseLock && reader.releaseLock();
  }
}

let cacheFetchRequest = async (request, cache, { clientId } = {}) => {
  let response;
  let work = Promise.resolve();
  try {
    response = await fetch(request);
    if (clientId) {
      work = Promise.all([
        clients.get(clientId),
        cache.match(request)
          .then(cacheStream => getStreamData(cacheStream.body)),
        getStreamData(response.clone().body),
      ])
        .then(([ client, cacheData, responseData ]) => {
          if (!cacheData || !responseData) { return; }
          if (!cacheData.every((value, i) => value === responseData[i])) {
            client.postMessage({
              type: "cache expiry"
            });
          }
        });
    }
    work.then(() => cache.put(request, response.clone()));
  } catch (error) {
    throw `fetch failed: ${error}`;
  }

  return response;
}

let cacheFirst = async ({ request, clientId }) => {
  let cache = await caches.open(cacheName);
  let fetchResponse = cacheFetchRequest(request, cache, { clientId });
  let response;
  try {
    response = await cache.match(request);
    if (!response) { throw "No cache"; }
  } catch (error) {
    response = await fetchResponse;
  }
  return response;
};

let networkFirst = async ({ request }) => {
  let cache = await caches.open(cacheName);
  let response;
  try {
    response = await cacheFetchRequest(request, cache);
  } catch (e) {
    response = await cache.match(request);
  }
  return response;
}

self.addEventListener("fetch", async event => {
  if(!event.request.url.startsWith("http")) { return };

  if (/\.json(\?|$)/.test(event.request.url)) {
    event.respondWith(networkFirst(event));
  } else {
    event.respondWith(cacheFirst(event));
  }
});
