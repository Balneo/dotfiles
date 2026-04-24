#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPS_DIR="$HOME/.local/share/applications"

mkdir -p "$APPS_DIR"

for f in "$SCRIPT_DIR"/desktop/*.desktop; do
    [ -e "$f" ] || { echo "No .desktop files found in $SCRIPT_DIR/desktop"; exit 1; }
    ln -sfv "$f" "$APPS_DIR/$(basename "$f")"
done

# Refresh the desktop database so walker/elephant picks them up immediately
if command -v update-desktop-database >/dev/null; then
    update-desktop-database "$APPS_DIR"
fi

echo "Done. Try: walker → type 'bar'"
