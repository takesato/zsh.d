alias reload='exec $SHELL -l'

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



alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n 1`'
alias -g H='`curl -sL https://api.github.com/users/takesato/repos | jq -r ".[].full_name" | peco --prompt "GITHUB REPOS>" | head -n 1`'
alias -g LR='`git branch -a | peco --query "remotes/ " --prompt "GIT REMOTE BRANCH>" | head -n 1 | sed "s/remotes\/[^\/]*\/\(\S*\)/\1 \0/"`'
