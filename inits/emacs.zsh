export ALTERNATE_EDITOR=""
export EDITOR='emacsclient -t'
if [ "$EMACS" ];then
  export TERM=xterm-256color
fi
