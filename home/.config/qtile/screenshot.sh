#!/bin/sh

screenshot_path="$HOME/screenshot-$(date +%y-%m-%d--%H-%M-%S).png"

if [ "$1" = "full" ]; then
    maim --hidecursor $screenshot_path
else
    maim --hidecursor --windowid=$(xdotool getactivewindow) $screenshot_path
fi;

xclip -selection clipboard -target image/png -in $screenshot_path
rm $screenshot_path

notify-send "screenshot copied"
