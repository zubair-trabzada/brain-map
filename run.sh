#!/usr/bin/env bash
# brain-map one-command runner
#   curl -fsSL https://raw.githubusercontent.com/zubair-trabzada/brain-map/main/run.sh | bash -s -- ~/path/to/your/notes
set -euo pipefail

VAULT="${1:-$PWD}"
VAULT="${VAULT/#\~/$HOME}"
if [ ! -d "$VAULT" ]; then
  echo "✗ folder not found: $VAULT" >&2
  exit 1
fi

APP="$HOME/.brain-map-app"
BASE="https://raw.githubusercontent.com/zubair-trabzada/brain-map/main"
mkdir -p "$APP"
echo "→ fetching brain-map…"
curl -fsSL "$BASE/build.py" -o "$APP/build.py"
curl -fsSL "$BASE/index.html" -o "$APP/index.html"

python3 "$APP/build.py" --vault "$VAULT"
exec python3 "${VAULT%/}/.brain-map/serve.py"
