#!/bin/sh


export SYSTEM="$HOME/system"


export COLOUR_0="#282828"
export COLOUR_1="#cc241d"
export COLOUR_2="#98971a"
export COLOUR_3="#d79921"
export COLOUR_4="#458588"
export COLOUR_5="#b16286"
export COLOUR_6="#689d6a"
export COLOUR_7="#a89984"

export COLOUR_8="#928374"
export COLOUR_9="#fb4934"
export COLOUR_10="#b8bb26"
export COLOUR_11="#fabd2f"
export COLOUR_12="#83a598"
export COLOUR_13="#d3869b"
export COLOUR_14="#8ec07c"
export COLOUR_15="#ebdbb2"

export BACKGROUND_COLOUR="$COLOUR_0"
export FOREGROUND_COLOUR="$COLOUR_15"
export HIGHLIGHT_COLOUR="#af3a03"

export MONO_FONT_NAME="Fira Mono"
export NORMAL_FONT_NAME="Lato"
export FONT_STYLE="Regular"
export SMALL_FONT_SIZE="11"
export NORMAL_FONT_SIZE="14"

export BORDER_WIDTH="3"
export LINE_HEIGHT="1.236"
export PADDING="8"
export PADDING_DOUBLED="16"


HOME_PATH="$HOME/.local/bin"
CARGO_PATH="$HOME/.cargo/bin"
FZF_PATH="$HOME/.local/opt/fzf/bin"
export PATH="$FZF_PATH:$CARGO_PATH:$HOME_PATH:$PATH"


export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore --follow"
