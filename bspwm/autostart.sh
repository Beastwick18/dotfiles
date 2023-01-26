#!/bin/sh

# Start syndaemon for palm rejection
syndaemon -i 0.5 -t -K -d

xmodmap "$HOME"/.config/xmodmap/.Xmodmap
sxhkd &
touchegg &
xsetroot -cursor_name left_ptr
bash "$HOME"/.config/bspwm/launch_discord.sh &
batsignal -b -w 20 &
nm-applet &
blueman-applet &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

ps cax | grep clight > /dev/null
if [ $? -ne 0 ]; then
    clight &
fi

ps cax | grep clight-gui > /dev/null
if [ $? -ne 0 ]; then
    clight-gui --tray &
fi

# Run cleanfullscreen if not already running
if [ ! $(ps aux | grep "[c]leanfullscreen.sh") ]; then
    # dunstify Running cleanfullscreen
    bash "$HOME"/.config/bspwm/cleanfullscreen.sh &
fi

