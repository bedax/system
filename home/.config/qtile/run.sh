#!/bin/sh

. "$HOME/.profile"

font_name="FuraMonoForPowerline Nerd Font"
font_style="style=Regular"
font_size="pixelsize=14"
font_aliasing="antialias=true"
font_hinting="autohint=false"
font="$font_name:$font_style:$font_size:$font_aliasing:$font_hinting"

background_colour="#3c3836"
foreground_colour="#fbf1c7"
highlight_colour="#af3a03"

dmenu_run \
   -b \
   -i \
   -l 7 \
   -fn "$font" \
   -nb "$background_colour" \
   -nf "$foreground_colour" \
   -sb "$highlight_colour" \
   -sf "$foreground_colour"
