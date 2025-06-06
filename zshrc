[[ -f ~/.zshrc_local_pre ]] && source ~/.zshrc_local_pre

source ~/.zsh/tmux.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/keybindings.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh

[[ -f /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found # Debian/Ubuntu (install the command-not-found package)
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh # Arch Linux (install the pkgfile package)
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
which batman &> /dev/null && eval $(batman --export-env)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local
