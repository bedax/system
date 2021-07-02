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
export WARNING_COLOUR="$COLOUR_12"

export FONT_SIZE="14"
export MONO_FONT_NAME="Fira Mono"
export MONO_FONT_STYLE="Medium"
export NORMAL_FONT_NAME="Inter"
export SUCKLESS_FONT_SIZE="18"

export PADDING="8"
export PADDING_DOUBLED="16"
export LINE_HEIGHT="1.236"
export BORDER_WIDTH="3"

export SYSTEM="$HOME/system"

LOCAL_PATH="$HOME/.local/bin"
export PATH="$LOCAL_PATH:$PATH"

eval "$(luarocks path)"

# should be a whole number
# calculate with: https://www.sven.de/dpi/
# referenced in: .Xresources, .config/gtk-3.0/settings.ini, and .gtkrc-2.0
# also update: .mozilla/firefox/user.js; layout.css.devPixelsPerPx
# also update: the QT_SCALE_FACTOR below
export DPI=176

# scales sigil
export QT_SCALE_FACTOR=1.4
export QT_AUTO_SCREEN_SCALE_FACTOR=0
