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
[[ -f /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh
[[ -f ~/.dotfiles/ranger-autojump/ranger-autojump.plugin.zsh ]] && source ~/.dotfiles/ranger-autojump/ranger-autojump.plugin.zsh
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
