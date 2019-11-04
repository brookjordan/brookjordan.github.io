const CACHE_NAME = 'css-ddr-cache-v1';

const FILES_TO_CACHE = [
  // icons
  './images/badge.svg',
  './images/maskable.svg',

  // css
  './entry.css',

  // html
  './index.html',

  // sprites
  './whoosh-up.svg',
  './whoosh-right.svg',
  './whoosh-down.svg',
  './whoosh-left.svg',
  './score-bar.svg',
  './level.svg',
];

self.addEventListener('install', (event) => {
  self.skipWaiting();

  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        return cache.addAll(FILES_TO_CACHE);
      })
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys()
      .then((keyList) => {
        return Promise.all(keyList.map((key) => {
          if (key !== CACHE_NAME) {
            return caches.delete(key);
          }
        }));
      })
  );

  self.clients.claim();
});

self.addEventListener('fetch', (event) => {
  if (event.request.mode !== 'navigate') { return; }

  event.respondWith(
    fetch(event.request)
      .catch(() => {
        return caches.open(CACHE_NAME)
          .then((cache) => {
            return cache.match('offline.html');
          });
      })
  );
});
