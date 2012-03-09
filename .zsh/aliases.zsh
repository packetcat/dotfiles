alias rmdir='rm -r'
alias sl='ls'
alias myip="wget -qO- ifconfig.me/ip"
alias memoryhog="ps aux | sort -nk +4 | tail"
alias stripext="ls -1 | sed 's/\(.*\)\..*/\1/'"
alias macgen="openssl rand -hex 6 | sed 's/\(..\)/\1:/g;s/../00/;s/.$//' | tr "[a-z]" "[A-Z]""
