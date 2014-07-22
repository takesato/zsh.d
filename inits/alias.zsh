p() { peco | while read LINE; do $@ $LINE; done }
alias o='git ls-files | p open'
alias e='ghq list -p | p cd'

alias ec='emacsclient -t'

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i -v"
alias tmux="tmux -u"              # 日本語文字化け対策

# http://qiita.com/items/1535#comment-1538
alias gitroot='cd `git rev-parse --show-toplevel`'

####################################################################################################
### coreutils
### $ brew install coreutils
alias ls='gls -v --color=auto'
alias date='gdate'

####################################################################################################
### one length shortcut

alias b='bundle'
#alias p="padrino"

