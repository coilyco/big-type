# Per-repo task manifest. Run `just` (or `just --list`) to see every verb.
#
# One line of comment per recipe on purpose: just reads only the LAST comment
# line above a recipe, so a wrapped description silently truncates to its tail.

set positional-arguments

# Default target: list every available recipe.
default:
    @just --list --unsorted

# Run the repo gate (pre-commit over every file).
test *ARGS:
    @bash scripts/test-gate.sh "$@"

# Build the image locally and run the smoke test against it.
smoke:
    @docker build -q -t big-type:local . >/dev/null && bash scripts/smoke-image.sh big-type:local

# Serve the built image on http://127.0.0.1:18080 until Ctrl-C.
serve:
    @docker build -q -t big-type:local . >/dev/null && docker run --rm -p 18080:8080 big-type:local
