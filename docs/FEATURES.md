# Features

What `big-type` currently ships.

## Inventory

- **Typing toy** - one full-screen glyph per key press, white on black,
  letters upper-cased, emoji in native color and kept whole across multi-part
  sequences. Works with a physical keyboard and with the on-screen keyboard on
  phones and tablets. See [origin.md](origin.md).
- **Installable offline app** - a web manifest for full-screen home-screen
  install, and a network-first service worker so the toy opens with no signal.
- **Container image** - unprivileged nginx on 8080 with `/healthz`, smoke-tested
  and then published to the Forgejo registry at the full commit SHA on every
  push to main. Rollout lives in `coilyco/deploy`.

## See also

- [README.md](../README.md) - human-facing intro.
- [AGENTS.md](../AGENTS.md) - agent-facing context.
