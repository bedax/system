#!/bin/sh


EMSDK_PATH="$EMSDK:$EMSDK/clang/e1.38.0_64bit:$EMSDK/node/8.9.1_64bit/bin:$EMSDK/emscripten/1.38.0"
HOME_PATH="$HOME/.local/bin"
CARGO_PATH="$HOME/.cargo/bin"
NPM_PATH="$HOME/.npm-global/bin"
FZF_PATH="$HOME/.local/opt/fzf/bin"
export PATH="$EMSDK_PATH:$NPM_PATH:$CARGO_PATH:$FZF_PATH:$HOME_PATH:$PATH"

export EMSDK="$HOME/.local/opt/emsdk"
export NPM_CONFIG_PREFIX=~/.npm-global
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore --follow"
