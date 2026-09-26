# Origin

big type was written as a claude.ai chat artifact and never had a repository.
The chat was later lost. The only surviving copy was a browser "Save Page As"
of that chat, taken on 2026-09-26, which captured an older version of the
artifact.

## What was recovered

The saved page nests the artifact two frames deep. The game is lines 419 to
599 of `a_dJoM.html` in the save's `553b7e58-..._data/` folder. Lines 1 to 417
are claude.ai's sandbox bridge and were dropped. That copy had SHA-256
`464ced04a1837069e3348fcb79a8974383236f0a1b21b3b20e76d5387662273d`.

## What changed on the way in

- The browser save dropped the closing `</body>`, so it was restored.
- The artifact left two `SPLIT:` markers for "after the k3s split". The web
  manifest, icon links, and service worker registration now fill them.
- The saved version cycled letters through an eight-color palette with a
  colored glow. Kai's latest version, which did not survive, was plain white on
  black with emoji in native color. That was recreated from her description:
  the palette and glow are gone, and every glyph uses one foreground color.
- That change also fixed a bug in the saved version. Digits and symbols took
  `color: inherit`, which resolved to the browser's default black, so they drew
  black on the near-black background.
