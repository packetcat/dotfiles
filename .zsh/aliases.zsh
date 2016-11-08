alias rmdir='rm -r'
alias sl='ls'
alias memoryhog="ps aux | sort -nk +4 | tail"
alias stripext="ls -1 | sed 's/\(.*\)\..*/\1/'"
alias macgen="openssl rand -hex 6 | sed 's/\(..\)/\1:/g;s/../00/;s/.$//' | tr '[a-z]' '[A-Z]'"
alias quickpwgen="tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"

if [ "$DISABLE_LS_COLORS" != "true" ]
then
    # Find the option for using colors in ls, depending on the version: Linux or BSD
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi
