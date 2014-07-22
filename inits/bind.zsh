# emacs key bind
bindkey -e

bindkey -s maek make
bindkey -s amke make
bindkey -s grpe grep
#bindkey -s 'sv ndi' 'svn di'
#bindkey -s 'sv nst' 'svn st'

# autoload
bindkey '^R' history-incremental-search-backward


# 先頭マッチのヒストリサーチ(進む)
bindkey '^P' history-beginning-search-backward


# 先頭マッチのヒストリサーチ(戻る)
bindkey '^N' history-beginning-search-forward