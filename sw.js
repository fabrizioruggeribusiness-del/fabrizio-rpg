// Service worker minimale — cache offline dell'app
const CACHE = 'fabrizio-rpg-v2';
const ASSETS = [
  'index.html',
  'manifest.json',
  'stage0.png','stage1.png','stage2.png','stage3.png','stage4.png',
  'icon.png'
];

self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE).then(c =>
      // addAll fallisce se manca un file: aggiungiamo uno a uno ignorando gli errori
      Promise.all(ASSETS.map(a => c.add(a).catch(() => {})))
    )
  );
  self.skipWaiting();
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request).then(r => r || fetch(e.request))
  );
});
