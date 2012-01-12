autoload -U compinit promptinit
compinit
promptinit

#prompt
prompt elite2

#opts
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB

# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history

#aliases
alias rmdir='rm -r'
alias sl='ls'
alias octalperm="ls -l | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf("%0o ",k);print}'"
alias myip="wget -qO- ifconfig.me/ip"
alias memoryhog="ps aux | sort -nk +4 | tail"