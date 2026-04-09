#!/bin/bash

scriptname=$(basename $0)
running_count=$(ps aux | grep -i "${scriptname}" | grep -v "grep" | wc -l)
if [ $running_count -gt 2 ]; then
  echo "Exiting: Already running..."
  exit
fi

logger "${scriptname} started"

function handle {
  case $1 in
  monitoraddedv2*)
    killall -9 hyprpanel
    hyprpanel &
    disown %-
    ;;
  monitorremoved*)
    killall -9 hyprpanel
    hyprpanel &
    disown %-
    ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
