# append command to history file once executed
setopt inc_append_history
# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS
# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS
# Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt EXTENDED_GLOB
setopt AUTO_CD

# display PID when suspending processes as well
setopt longlistjobs
# try to avoid the 'zsh: no matches found...'
setopt nonomatch
# Turn off flow control
setopt noflowcontrol
# report the status of backgrounds jobs immediately
setopt notify
# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all
