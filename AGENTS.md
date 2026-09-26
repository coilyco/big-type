---
ward:
  workflow: pull-request-and-merge
---
# Agent instructions

This repo is big type, a full-screen toddler typing toy served at
typing.coilysiren.me.

## Scope

- `site/` is the product. It is plain HTML, CSS, and JavaScript with no build
  step and no dependencies. Keep it that way.
- The audience is a toddler with a tablet. Anything that can zoom, scroll,
  navigate away, or show a dialog is a bug.
- `THINGS` in `site/index.html` maps a word to its picture. It holds objects
  only: animals, food, vehicles, toys, nature. Never people, faces, hands, or
  gestures, which in practice means no emoji that takes a skin-tone modifier.

## Project shape

- `site/index.html` holds the whole game. `site/sw.js` is the service worker,
  and `site/manifest.webmanifest` plus `site/icons/` make it installable.
- `Dockerfile` and `nginx.conf` serve `site/` from nginx-unprivileged on 8080.
- `scripts/` holds the repo gate, the image smoke test, and the trusted image
  publisher. `README.md`, `AGENTS.md`, `docs/FEATURES.md`, and the `justfile`
  are the baseline trio plus command surface.

## Repo boundaries

- `coilyco/deploy` owns rollout, the pull credential, DNS, and TLS. This repo
  owns the image and the workflow that publishes it.
- The deploy side depends on `GET /` returning 200 on 8080 and on the image
  tag being the full 40-character commit SHA. `scripts/smoke-image.sh` checks
  the first, and `scripts/publish-image.sh` enforces the second.

## Commands

Route every dev command through the [`justfile`](justfile). Bare `just` lists
the verbs.

## Validation

Run `just test` for pre-commit and `just smoke` for the image. `just smoke`
needs a local Docker daemon.

## Safety

The page collects nothing and calls nothing off-origin. Keep it that way: no
analytics, no fonts or scripts from a CDN, no storage beyond the service
worker's own cache.

## Cross-repo contracts

- Image: `forgejo.coilysiren.me/coilyco/big-type:<full sha>`, pinned by
  `coilyco/deploy` in `services/big-type/values.env`.
- `documentation-size` is left out of the hook list until the repo has a
  ratified band in the documentation policy.

## Release

Every push to main runs `build-publish`, which builds, smoke-tests, and pushes
the SHA-tagged image. There is no `latest` tag. The deploy side's pin
reconciler picks up new SHAs.

## Agent rules

<!-- BEGIN managed by agentic-os/scripts/apply-git-workflow.py -->
### Git workflow

**This repo runs the `pull-request-and-merge` lane**, declared as `ward.workflow` in this file's frontmatter. The agent commits to a task branch, pushes it, opens a Forgejo pull request, and **merges that pull request itself** once it is green. The author of the code is the one who merges it. Opening the pull request is a step, never the stopping point.

The fleet runs one lane, and it authorizes the agent end to end. Pushing straight to `main` is over: `merge-remote-main` is retired, so no repo can declare its way back to one.

* `pull-request-and-merge` - the agent commits to a task branch, pushes it, opens a pull request, and merges that pull request itself once it is green.

**Every lane slug names what the AGENT does, never what someone else does.** `pull-request-and-merge` carries the merge because the agent that authored the code merges its own pull request. `pull-request` drops `-and-merge` because the author stops at the pull request and the director merge lane takes over. Reading `pull-request-and-merge` as "someone else merges it later" inverts the two and leaves finished work sitting unmerged.

**These actions are pre-authorized on every lane, and the agent MUST take them without asking first.** Committing, creating a branch, pushing a branch, pushing the lane's own destination, and opening a pull request are ordinary reversible work, not the destructive wall that earns a question. Stopping to ask is how a turn ends with the work stranded in a dirty worktree.

* **ALWAYS commit** in-scope work and **ALWAYS push** it to the canonical remote before pausing, reporting a checkpoint, handing off, or ending a turn. A local-only commit is not a checkpoint.
* **ALWAYS open the pull request** in the same turn as the branch's first push, on every lane except `remote-branch-only`. A pushed branch with no pull request is litter nobody reviews.
* **NEVER `--no-verify`** and **NEVER force-push**. Those two are the real walls, and they stay closed.
* **ALWAYS merge your own pull request on `pull-request-and-merge`**, in the same turn, as soon as it is green. Reporting it as open and awaiting someone is the failure this lane exists to prevent.
* **NEVER merge on `pull-request` or `remote-branch-only`.** Those two stop where they stop, and the director merge lane carries a `pull-request` from there.
<!-- END managed by agentic-os/scripts/apply-git-workflow.py -->

## See also

- [README.md](README.md) - human-facing intro.
- [docs/FEATURES.md](docs/FEATURES.md) - what ships today.
