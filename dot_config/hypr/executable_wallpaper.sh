#!/usr/bin/env bash
set -euo pipefail
sleep 5
WALLPAPER_DIR="/usr/share/backgrounds/archlinux"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
if [ -z "${WALLPAPER:-}" ]; then
	echo "No wallpaper found in: $WALLPAPER_DIR" >&2
	exit 1
fi

# Apply the selected wallpaper (fallback: empty monitor)
# Ref: https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/
hyprctl hyprpaper wallpaper ", $WALLPAPER"