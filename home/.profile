source ~/.local/opt/emsdk/emsdk_env.sh > /dev/null

export PATH="$HOME/.local/bin/:$HOME/.cargo/bin:$HOME/.npm-global/bin:$HOME/.local/opt/fzf/bin:$PATH"

export NPM_CONFIG_PREFIX=~/.npm-global

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore --follow"
