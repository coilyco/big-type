#!/usr/bin/env bash
# Run a built image and assert what the deploy side depends on: GET / is 200
# (liveness/readiness probe), /healthz, and the PWA files. Requests go through
# `docker exec` so the check needs no published port and works under DinD.
set -euo pipefail

image="${1:?usage: smoke-image.sh <image>}"
name="big-type-smoke-$$"

docker run -d --rm --name "${name}" "${image}" >/dev/null
trap 'docker rm -f "${name}" >/dev/null 2>&1 || true' EXIT

get() { docker exec "${name}" wget -qO- "http://127.0.0.1:8080$1"; }

for _ in $(seq 1 20); do
  get /healthz >/dev/null 2>&1 && break
  sleep 0.5
done

fail=0
check() {
  if get "$1" | grep -q "$2"; then
    echo "ok   $1 contains '$2'"
  else
    echo "FAIL $1 missing '$2'" >&2
    fail=1
  fi
}

check /healthz 'ok'
check / '<title>big type</title>'
check /index.html 'Intl.Segmenter'
check /no/such/path '<title>big type</title>'
check /manifest.webmanifest '"display": "fullscreen"'
check /sw.js 'big-type-v1'
check /icons/icon.svg '<svg'
# busybox wget exits non-zero on 4xx, so read its headers without pipefail.
headers() { docker exec "${name}" wget -qS -O /dev/null "http://127.0.0.1:8080$1" 2>&1 || true; }
check_header() {
  if headers "$1" | grep -q "$2"; then
    echo "ok   $1 header '$2'"
  else
    echo "FAIL $1 header missing '$2'" >&2
    fail=1
  fi
}

check_header /icons/icon-192.png 'Content-Type: image/png'
check_header /icons/missing.png ' 404 '
check_header / 'Cache-Control: no-cache'
check_header /sw.js 'Cache-Control: no-cache'

exit "${fail}"
