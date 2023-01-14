#!/usr/bin/env bash

set -euxo pipefail

WALLPAPER_DIR="${HOME}/Pictures/wallpapers/"
WALLPAPER=$(find "${WALLPAPER_DIR}" -type f | shuf -n 1)

feh --bg-scale "${WALLPAPER}"