const cacheName = 'placeholder-v1';
const staticAssets = [
  './',
  './index.html',
  'https://fonts.googleapis.com/css?family=Coming+Soon&display=swap',
  'main.1.0.2.css',

  './query-params--1.0.0.js',
  './words--3.2.1.js',
  './verbs--2.2.1.js',
  './extra-people--1.1.0.js',
  './people--2.2.1.js',
  './main.js',
  './settings--2.0.0.js',
  './init-pwa.js',

  './yousleptwith.ico',
  './sheateabig.ico',
  './hethrewher.ico',
  './favicon.ico',
];

async function cacheFirst(req) {
  const cache = await caches.open(cacheName); 
  const cachedResponse = await cache.match(req); 
  return cachedResponse || fetch(req); 
}

self.addEventListener('install', async event => {
  const cache = await caches.open(cacheName); 
  await cache.addAll(staticAssets);
});

self.addEventListener('fetch', async event => {
  const req = event.request;
  event.respondWith(cacheFirst(req));
});
