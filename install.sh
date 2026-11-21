#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REAPER_DIR="$HOME/.config/REAPER"

mkdir -p "$REAPER_DIR/Effects" "$REAPER_DIR/TrackTemplates" "$REAPER_DIR/ProjectTemplates"

ln -sf "$REPO_DIR/Effects/"* "$REAPER_DIR/Effects/"
ln -sf "$REPO_DIR/TrackTemplates/"* "$REAPER_DIR/TrackTemplates/"
ln -sf "$REPO_DIR/ProjectTemplates/"* "$REAPER_DIR/ProjectTemplates/"

echo "Symlinked JSFX and templates into $REAPER_DIR"
