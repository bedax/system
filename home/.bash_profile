if [[ ! $DISPLAY && $XDG_VTNR -le 1 ]]; then
   exec startx > /dev/null 2>&1
else
   . ~/.bashrc
fi
