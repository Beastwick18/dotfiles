#!/bin/bash
bspc monitor "DP-4" -d '' '' '' ''
bspc wm --reorder-monitors DP-4 DP-0
# xrandr stuff
xrandr --output DP-4 --right-of DP-0 --primary --mode 1920x1080 --rate 164.92
xrandr --output DP-0 --mode 1920x1080 --rate 60.00
