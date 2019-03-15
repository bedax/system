if [[ ! $DISPLAY && $XDG_VTNR -le 1 ]]; then
   exec startx
fi
