#!/bin/sh

# compositor
compton --shadow-exclude argb &

# set the background
hsetroot -cover ~/.config/qtile/background.png &

# blue-light filter
redshift &

# enable audio
start-pulseaudio-x11 &

# battery icon and notifications for the systray
~/.local/bin/cbatticon --low-level 16 --critical-level 8 --hide-notification &

# pulseaudio volume control for the systray
~/.local/bin/pa-applet &

# network manager for the systray
#nm-applet &
wicd-gtk --tray &

# backlight
xbacklight -set 75

# nextcloud's sync client
#~/.local/bin/nextcloud &

# for thunar's mounter and gparted-pkexec; from 'policykit-1-gnome' package
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

#system-config-printer-applet

# not available on stretch (also depends on systemd):
#/usr/lib/gnome-disk-utility/gdu-notification-daemon
