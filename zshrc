[[ -f ~/.zshrc_local_pre ]] && source ~/.zshrc_local_pre

source ~/.zsh/tmux.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/keybindings.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/overrides.zsh

[[ -f /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found # Debian/Ubuntu (install the command-not-found package)
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh # Arch Linux (install the pkgfile package)
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# equivalent to sourcing completion.zsh and key-bindings.zsh
which fzf &> /dev/null && source <(fzf --zsh)
which batman &> /dev/null && eval $(batman --export-env)
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local
