# 単語として認識したい文字
export WORDCHARS='*?-[]~\!#%^(){}<>|`@#%^*()+:?'

# default mask
umask 002
setopt IGNOREEOF

### history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
