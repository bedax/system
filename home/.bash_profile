if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -le 1 ]; then
   exec startx > /dev/null
else
   . ~/.bashrc
fi
