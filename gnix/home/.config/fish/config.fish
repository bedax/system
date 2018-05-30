# prompt
## from: https://wiki.archlinux.org/index.php/Fish#Put_git_status_in_prompt
set __fish_git_prompt_showdirtystate "yes"
set __fish_git_prompt_showstashstate "yes"
set __fish_git_prompt_showupstream "yes"

function fish_prompt
    printf "%s%s%s%s %s>%s " \
        (set_color $fish_color_cwd) \
        (prompt_pwd) \
        (set_color $fish_color_quote) \
        (__fish_git_prompt) \
        (set_color normal) \
        (set_color normal)
end


# Turn off the greeting
#set fish_greeting


# Fix the del key
## from: https://github.com/fish-shell/fish-shell/issues/2139#issuecomment-305506138
if status is-interactive
    switch $TERM
        # Fix DEL key in st
        case 'st*'
            set -gx is_simple_terminal 1

        case "linux"
            set -ex is_simple_terminal
            function fish_prompt
                fish_fallback_prompt
            end
    end

    if set -q is_simple_terminal
        tput smkx ^/dev/null
        function fish_enable_keypad_transmit --on-event fish_postexec
            tput smkx ^/dev/null
        end

        function fish_disable_keypad_transmit --on-event fish_preexec
            tput rmkx ^/dev/null
        end
    end
end
