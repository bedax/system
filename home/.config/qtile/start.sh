#!/bin/sh

# set the background
hsetroot -cover ~/.config/qtile/background.png &

# compositor
compton --shadow-exclude argb &

# blue-light filter
redshift &

# backlight
xbacklight -set 40

# enable audio
start-pulseaudio-x11 &

# pulseaudio volume control for the systray
~/.local/bin/pa-applet &

# battery icon and notifications for the systray
~/.local/bin/cbatticon --low-level 16 --critical-level 8 --hide-notification &

# for thunar's mounter and gparted-pkexec; from 'policykit-1-gnome' package
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# network manager for the systray
#nm-applet &
#wicd-gtk --tray &

# disable the capslock; remaps it to the left shift key
#xmodmap -e "keycode 66 = Shift_L NoSymbol Shift_L" &

#system-config-printer-applet

# not available on stretch (also depends on systemd):
#/usr/lib/gnome-disk-utility/gdu-notification-daemon
