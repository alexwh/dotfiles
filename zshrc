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
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local
