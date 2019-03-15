if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -le 1 ]; then
   exec startx
else
   fish
fi
