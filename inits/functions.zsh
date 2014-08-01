unixtime() {
  date_bin=gdate
  if [ $# = 1 ]
  then
    ${date_bin} -d "1970/01/01 09:00:00 $1 seconds" "+%Y/%m/%d %H:%M:%S"
  else
    ${date_bin} +%Y/%m/%d\ %H:%M:%S
  fi
}

# http://sakito.jp/mac/dictionary.html#terminal
dict() {
  open dict:///"$@";
}

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

alias cdd='cd `ghq list -p|peco`'

function peco-snippets() {

    local SNIPPETS=$(grep -v "^#" ~/.snippets | peco --query "$LBUFFER" | pbcopy)
    zle clear-screen
}

zle -N peco-snippets
bindkey '^x^s' peco-snippets

function peco-select-gitadd() {
  local selected_file_to_add=$(git status --porcelain | \
    peco --query "$LBUFFER" | \
    awk -F ' ' '{print $NF}')
  if [ -n "$selected_file_to_add" ]; then
    BUFFER="git add ${selected_file_to_add}"
    CURSOR=$#BUFFER
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-select-gitadd
bindkey "^g^a" peco-select-gitadd

function peco-switch-branch() {
  local branch=$(
    (
      for i in `git branch | colrm 1 2|grep -v detached`;
      do
        echo `git log --date=iso8601 -n 1 --pretty="format:[%ai] %h" $i` $i;
        done
    ) | sort -r|peco --query "$LBUFFER" | cut -f 5 -d" ")
  if [ -n "$branch" ]; then
    BUFFER="git checkout ${branch}"
    CURSOR=$#BUFFER
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-switch-branch
bindkey '^x^b' peco-switch-branch
