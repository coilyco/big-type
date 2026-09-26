#!/usr/bin/env bash
# The repo gate: pre-commit over every file. The image smoke test needs a
# Docker daemon, so it runs in `just smoke` locally and in publish-image.sh
# before every push to the registry.
set -euo pipefail

if ! command -v pre-commit >/dev/null 2>&1; then
  echo "pre-commit not found on PATH" >&2
  exit 127
fi

pre-commit run --all-files
