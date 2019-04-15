#!/bin/sh

# base16-ashes-dark
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

export MONO_FONT_NAME="Fira Mono"
export NORMAL_FONT_NAME="Lato"
export FONT_STYLE="Regular"
export SMALL_FONT_SIZE="11"
export NORMAL_FONT_SIZE="14"

export BORDER_WIDTH="3"
export LINE_HEIGHT="1.236"
export PADDING="8"
export PADDING_DOUBLED="16"

export SYSTEM="$HOME/system"

HOME_PATH="$HOME/.local/bin"
CARGO_PATH="$HOME/.cargo/bin"
FZF_PATH="$HOME/.local/opt/fzf/bin"
export PATH="$FZF_PATH:$CARGO_PATH:$HOME_PATH:$PATH"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore --follow"
