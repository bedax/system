#!/bin/sh

# base16-ashes
export COLOUR_0="#1c2023"
export COLOUR_1="#c7ae95"
export COLOUR_2="#95c7ae"
export COLOUR_3="#aec795"
export COLOUR_4="#ae95c7"
export COLOUR_5="#c795ae"
export COLOUR_6="#95aec7"
export COLOUR_7="#c7ccd1"
export COLOUR_8="#747c84"
export COLOUR_9="#c7ae95"
export COLOUR_10="#95c7ae"
export COLOUR_11="#aec795"
export COLOUR_12="#ae95c7"
export COLOUR_13="#c795ae"
export COLOUR_14="#95aec7"
export COLOUR_15="#f3f4f5"

export BACKGROUND_COLOUR="$COLOUR_0"
export FOREGROUND_COLOUR="$COLOUR_15"
export HIGHLIGHT_COLOUR="$COLOUR_14"

export NORMAL_FONT_SIZE="11"
export SUCKLESS_FONT_SIZE="14"
export SUCKLESS_FONT_STYLE="Regular"
export MONO_FONT_NAME="Fira Mono"
export NORMAL_FONT_NAME="Inter"

export PADDING="8"
export PADDING_DOUBLED="16"
export LINE_HEIGHT="1.236"
export BORDER_WIDTH="2"

export SYSTEM="$HOME/system"
export EDITOR="mousepad"

HOME_PATH="$HOME/.local/bin"
CARGO_PATH="$HOME/.cargo/bin"
DJV_PATH="/usr/local/DJV/bin/"
export PATH="$DJV_PATH:$CARGO_PATH:$HOME_PATH:$PATH"

# see: https://www.sven.de/dpi/
# and also update firefox's user.js and dev-user.js
export DPI=102.46

# not sure what these do anymore:
# export QT_SCALE_FACTOR=1.4
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
