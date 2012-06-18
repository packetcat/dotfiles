autoload -U compinit promptinit edit-command-line
compinit
promptinit
zle -N edit-command-line

#prompt
prompt clint

source ~/.zsh/setopt.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/zsh_hooks.zsh
source ~/.zsh/bindings.zsh

