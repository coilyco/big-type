# Features

What `big-type` currently ships.

## Inventory

- **Spell-a-thing typing toy** - typed letters build up white on black and
  shrink to fit, and a word from the built-in list of about 260 things pops up
  its emoji picture. Keys that lead to no listed word are ignored, so every
  word on screen is on its way to a thing. Words never break across rows. Works with a physical keyboard and with the on-screen keyboard
  on phones and tablets. See [origin.md](origin.md).
- **Installable offline app** - a web manifest for full-screen home-screen
  install, and a network-first service worker so the toy opens with no signal.
- **Container image** - unprivileged nginx on 8080 with `/healthz`, smoke-tested
  and then published to the Forgejo registry at the full commit SHA on every
  push to main. Rollout lives in `coilyco/deploy`.

## See also

- [README.md](../README.md) - human-facing intro.
- [AGENTS.md](../AGENTS.md) - agent-facing context.
