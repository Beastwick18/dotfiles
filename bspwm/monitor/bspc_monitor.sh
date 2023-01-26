#!/bin/bash
bspc monitor "DP-4" -d '' '' '' ''
# bspc wm --reorder-monitors eDP-4 DP-0
# xrandr stuff
xrandr --output eDP-1 --primary --mode 1920x1080 --rate 120.00
