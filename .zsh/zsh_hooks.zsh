#hooks
case $TERM in
        xterm*)
            precmd () {print -Pn "\e]0;%n@%m: %~\a"}
            ;;
esac

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}

