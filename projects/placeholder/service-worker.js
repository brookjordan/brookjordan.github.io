const cacheName = 'placeholder-v1';
const staticAssets = [
  './',
  './index.html',
  './manifest.json',
  './main.1.0.2.css',
  'https://fonts.googleapis.com/css?family=Coming+Soon&display=swap',

  './favicon.ico',
  './sheateabig.ico',
  './hethrewher.ico',
  './yousleptwith.ico',

  './main.js',
  './words--3.2.1.js',
  './verbs--2.2.1.js',
  './people--2.2.1.js',
  './settings--2.0.0.js',
  './query-params--1.0.0.js',
  './extra-people--1.1.0.js',
];

self.addEventListener('install', event => {
  let preCache = async () => {
    const cache = await caches.open(cacheName); 
    await cache.addAll(staticAssets);
  };
  event.waitUntil(preCache());
});


let cacheFetchRequest = async (request, cache) => {
  let response;
  try {
    response = await fetch(request);
    cache.put(request, response.clone());
  } catch (error) {
    throw 'fetch failed';
  }
  return response;
}

let cacheFirst = async request => {
  let cache = await caches.open(cacheName);
  let fetchResponse = cacheFetchRequest(request, cache);
  let response;
  try {
    response = await cache.match(request); 
    if (!response) { throw 'No cache'; }
  } catch (error) {
    response = await fetchResponse;
  }
  return response;
};

let networkFirst = async request => {
  let cache = await caches.open(cacheName);
  let response;
  try { 
    response = await cacheFetchRequest(request, cache);
  } catch (e) { 
    response = await cache.match(request);
  }
  return response;
}

self.addEventListener('fetch', async event => {
  if(!event.request.url.startsWith('http')) { return };
  
  if (/\.json(\?|$)/.test(event.request.url)) {
    event.respondWith(networkFirst(event.request));
  } else {
    event.respondWith(cacheFirst(event.request));
  }
});
