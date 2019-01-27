bindkey -v

# from http://zshwiki.org/home/zle/bindkeys
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"   ]] && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey "${key[End]}"    end-of-line
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}"     ]] && bindkey "${key[Up]}"     up-line-or-search
[[ -n "${key[Down]}"   ]] && bindkey "${key[Down]}"   down-line-or-search
[[ -n "${key[Left]}"   ]] && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}"  ]] && bindkey "${key[Right]}"  forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish

bindkey '^[[Z' reverse-menu-complete # shift-tab
bindkey '^[[1;5C' forward-word # ctrl+right
bindkey '^[[1;5D' backward-word # ctrl+left


# Restore some keymaps removed by vim keybind mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^[.' insert-last-word

# Change prompt icon + color based on insert/normal vim mode in prompt
export PURE_PROMPT_VICMD_SYMBOL="%{$fg[green]%}❮%{$reset_color%}"

# And also a beam as the cursor
echo -ne '\e[5 q'

# Callback for vim mode change
function zle-keymap-select () {
    # Only supported in these terminals
    if [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "screen-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # Set block cursor
            echo -ne '\e[1 q'
        else
            # Set beam cursor
            echo -ne '\e[5 q'
        fi
    fi

    # Refresh prompt and call Pure super function
    prompt_pure_update_vim_prompt_widget
}

# Bind the callback
zle -N zle-keymap-select

# Reduce latency when pressing <Esc>
export KEYTIMEOUT=1
