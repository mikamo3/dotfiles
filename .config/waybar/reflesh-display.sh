#!/usr/bin/env bash
set -e
echo hoge
hyprctl dispatch dpms off DP-1
sleep 1
hyprctl dispatch dpms on DP-1
echo fuga