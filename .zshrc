autoload -U compinit promptinit
compinit
promptinit

#prompt
prompt elite2

#opts
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB
setopt AUTO_CD

#history stuff
# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history
# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS
# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS
# Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS

#aliases
alias rmdir='rm -r'
alias sl='ls'
alias myip="wget -qO- ifconfig.me/ip"
alias memoryhog="ps aux | sort -nk +4 | tail"
alias stripext="ls -1 | sed 's/\(.*\)\..*/\1/'"

#default apps
export EDITOR="vim"

#hooks
function precmd {
  # vcs_info
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}
