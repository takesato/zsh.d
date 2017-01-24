unixtime() {
  date_bin=gdate
  if [ $# = 1 ];
  then
    ${date_bin} -d "1970/01/01 09:00:00 $1 seconds" "+%Y/%m/%d %H:%M:%S"
  else
    ${date_bin} "+%Y/%m/%d\ %H:%M:%S"
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
  if [ -f "`pwd`/.snippets" ]; then
    BUFFER=$(grep -v '^#' `pwd`/.snippets ~/.snippets | sort | peco --query "$LBUFFER" | cut -d':' -f 2)
  else
    BUFFER=$(grep -v '^#' ~/.snippets | peco --query "$LBUFFER")
  fi
  CURSOR=$#BUFFER
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

function peco-switch-tmux-session() {
  local session=$(tmux list-session | peco | cut -d ":" -f 1)
  if [ -n "$session" ]; then
    `tmux switch-client -t $session`
  fi
  zle clear-screen
}

zle -N peco-switch-tmux-session
bindkey '^x^w' peco-switch-tmux-session

function peco-dfind() {
  local current_buffer=$BUFFER
  # .git系など不可視フォルダは除外
  local selected_dir="$(find . -maxdepth 5 -type d ! -path "*/.*"| peco)"
  if [ -d "$selected_dir" ]; then
    BUFFER="${current_buffer} \"${selected_dir}\""
    CURSOR=$#BUFFER
    # ↓決定時にそのまま実行するなら
    #zle accept-line
  fi
  zle clear-screen
}
zle -N peco-dfind
bindkey '^x^f' peco-dfind

function peco-gitbranch() {
    local current_buffer=$BUFFER

    # commiterdate:relativeを commiterdate:localに変更すると普通の時刻表示
    local selected_line="$(git for-each-ref --format='%(refname:short) | %(committerdate:relative) | %(committername) | %(subject)' --sort=-committerdate refs/heads refs/remotes \
        | column -t -s '|' \
        | peco \
        | head -n 1 \
        | awk '{print $1}')"
    if [ -n "$selected_line" ]; then
        BUFFER="${current_buffer} ${selected_line}"
        CURSOR=$#BUFFER
        # ↓そのまま実行の場合
        #zle accept-line
    fi
    zle clear-screen
}
zle -N peco-gitbranch
bindkey '^x^g' peco-gitbranch

# http://qiita.com/sona-tar/items/fe401c597e8e51d4e243
function git-changed-files(){
  git status --short | peco | awk '{print $2}'
}
alias -g F='$(git-changed-files)'

function git-hash(){
  git log --oneline --branches | peco | awk '{print $1}'
}
alias -g H='$(git-hash)'

# http://qiita.com/syui/items/1def3293fd9a593a4e19
function cddown_dir(){
  com='$SHELL -c "ls -AF . | grep / "'
  while [ $? = 0 ]
  do
    cdir=`eval $com | peco`
    if [ $? = 0 ];then
      cd $cdir
      eval $com
    else
      break
    fi
  done
  zle reset-prompt
}
zle -N cddown_dir
bindkey '^j' cddown_dir

# http://hotolab.net/blog/peco_select_path/
function peco-select-path() {
  local filepath="$(find . | grep -v '/\.' | peco --prompt 'PATH>')"
  if [ "$LBUFFER" -eq "" ]; then
    if [ -d "$filepath" ]; then
      BUFFER="cd $filepath"
    elif [ -f "$filepath" ]; then
      BUFFER="$EDITOR $filepath"
    fi
  else
    BUFFER="$LBUFFER$filepath"
  fi
  CURSOR=$#BUFFER
  zle clear-screen
}

if [ -x "`which peco 2> /dev/null`" ]; then
  zle -N peco-select-path
  bindkey '^x^p' peco-select-path # Ctrl+f で起動
fi

# https://gist.github.com/azu/afa457540e8288f2e26e
function peco-filefind() {
    local current_buffer=$BUFFER
    # .git系など不可視フォルダは除外
    local selected_dir="$(find . -maxdepth 1 -type f | peco)"
    if [ -e "$selected_dir" ]; then
        BUFFER="${current_buffer} \"${selected_dir}\""
        CURSOR=$#BUFFER
    fi
    zle clear-screen
}
zle -N peco-filefind
bindkey '^x^f' peco-filefind

function peco-dfind() {
    local current_buffer=$BUFFER
    # .git系など不可視フォルダは除外
    local selected_dir="$(find . -maxdepth 5 -type d ! -path "*/.*"| peco)"
    if [ -d "$selected_dir" ]; then
        BUFFER="${current_buffer} \"${selected_dir}\""
        CURSOR=$#BUFFER
        # ↓決定時にそのまま実行するなら
        #zle accept-line
    fi
    zle clear-screen
}
zle -N peco-dfind
bindkey '^x^d' peco-dfind


function git-blame-show() {
  local hash="$(git blame ${1}| peco|cut -d " " -f1)"
  if [ -n "$hash" ]; then
    git show ${hash}
  fi
}

ssh() {
  if [ -f ".ssh_config" ]; then
    /usr/bin/ssh -F .ssh_config "$@"
  else
    /usr/bin/ssh  "$@"
  fi
}
