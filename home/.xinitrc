# fixes a bug where dunst doesn't show when using systemd
# https://wiki.archlinux.org/index.php/Dunst#Dunst_fails_to_start_via_systemd
systemctl --user import-environment DISPLAY

exec bspwm
