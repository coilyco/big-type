# big type

A full-screen typing toy for toddlers, served at typing.coilysiren.me.

Type letters and they build up huge, white on black, shrinking to fit as the
line grows. When the letters spell a thing, the thing pops up above them:
C-A-T shows a cat, and carrying on to C-A-R-R-O-T swaps a car for a carrot.
The word list is about 260 objects, animals, foods, vehicles, and bits of
nature, all drawn with the device's own emoji. Backspace deletes a letter,
Enter clears the screen, and so does going past 40 letters.

Only letters and spaces reach the screen. Emoji typed from the keyboard, and
predictive text that swaps a word for an emoji, are dropped. On a phone or
tablet, the first tap opens the on-screen keyboard and keeps it open.

It installs to a home screen as a full-screen app and keeps working offline.

## Run it

```bash
just serve   # http://127.0.0.1:18080
just smoke   # build the image and check what the deploy probes depend on
just test    # pre-commit over every file
```

## Layout

- `site/` - the whole app: `index.html`, the web manifest, the service
  worker, and icons. There is no build step.
- `Dockerfile`, `nginx.conf` - an unprivileged nginx image on port 8080.
- `scripts/publish-image.sh` - builds, smoke-tests, and pushes
  `forgejo.coilysiren.me/coilyco/big-type:<full sha>` on every push to main.

Rollout, DNS, and TLS live in `coilyco/deploy` under `services/big-type`.

## Where it came from

The page began as a claude.ai artifact. See [docs/origin.md](docs/origin.md).

## License

MIT, see [LICENSE](LICENSE).

## See also

- [AGENTS.md](AGENTS.md) - agent-facing context.
- [docs/FEATURES.md](docs/FEATURES.md) - what ships today.
