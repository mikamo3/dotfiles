#!/bin/bash
active_class=$(hyprctl activewindow -j | jq -r .class 2>/dev/null)

if [ "$active_class" != "1Password" ]; then
    cliphist store
fi