#################################################
# オプション設定
# わからないときは man zshoptions
# http://www.ayu.ics.keio.ac.jp/~mukai/translate/zshoptions.html
#################################################
### CD
setopt pushd_silent
# 補完時に文字列末尾へカーソル移動
setopt ALWAYS_TO_END
# コマンド名がディレクトリ時にcdする
setopt AUTO_CD
# あいまい補完時に候補表示
setopt AUTO_LIST
# cd時に自動的にpushdする
setopt AUTO_PUSHD
# 同ディレクトリの複数のコピーをpushしない。
setopt PUSHD_IGNORE_DUPS

### Completion
#setopt auto_menu
# 曖昧な補完の時にビープ音を発しない
setopt NO_LIST_BEEP
unsetopt list_beep
setopt menu_complete
setopt always_last_prompt
setopt auto_name_dirs
unsetopt cdable_vars
setopt auto_param_keys


# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt AUTO_RESUME
# BEEPを使わない
setopt NO_BEEP
# cshスタイルのヒストリ拡張を使う
setopt BANG_HIST
# リダイレクション時の自動削除/生成を抑制。
# 削除時は `>!'  または `>|'
# 作成時は `>>!' または `>>|'
setopt NO_CLOBBER
# カーソルの位置に補なうことで単語を完成させようとする。
setopt COMPLETE_IN_WORD
# = のファイル名生成が利用される(`Filename Expansion' を参照のこと)。
setopt EQUALS
# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_FLOW_CONTROL
# シェル関数やスクリプトの source 実行時に、 $0 を一時的にその関数／スクリプト名にセットする。
setopt FUNCTION_ARGZERO
# `.' で開始するファイル名にマッチさせるとき、先頭に明示的に `.' を指定する必要がなくなる
setopt GLOB_DOTS

### History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZDOTDIR/.zsh_history
setopt hist_ignore_dups
setopt EXTENDED_HISTORY                 # コマンドの開始時のタイムスタンプ(エポックからの秒数)と実行時間(秒単位)をヒストリに含める。
setopt HIST_IGNORE_ALL_DUPS             # 同一コマンドヒストリの場合に、古いものを削除
setopt HIST_IGNORE_SPACE                # ヒストリ追加時に先頭余白削除
setopt HIST_REDUCE_BLANKS               # ヒストリ追加時に余白削除
setopt SHARE_HISTORY                    # コマンド履歴ファイルを共有する

setopt IGNOREEOF

### history

# 全引数にスペルミス訂正を試みる
setopt CORRECT_ALL
# (マルチバイト文字補完)
setopt PRINT_EIGHT_BIT
# プロンプトで変数拡張、コマンド置換、計算拡張が実行
setopt PROMPT_SUBST
# zsh line editor を利用
setopt ZLE
# シェル終了時に起動中ジョブにHUPシグナルを送らない
setopt NO_HUP
# <C-d>でログアウトしない
setopt IGNORE_EOF
# 対話的なシェルでもコメントを有効にする
setopt INTERACTIVE_COMMENTS
# ジョブリストがデフォルトでロングフォーマット
setopt LONG_LIST_JOBS
# バックグラウンドジョブ状態の即時報告
setopt NOTIFY
# 数値ファイル名マッチ時は数値順にソート
setopt NUMERIC_GLOB_SORT
# 補完リストその他でもASCII(7ビット)以上の文字(8ビット)文字を表示 

### Input/Output
# 自動修正機能(候補を表示)
setopt CORRECT
setopt sun_keyboard_hack
setopt interactive_comments
unsetopt hup

### Prompting
#setopt prompt_subst

### Globing
# `#' `~' `^' といった文字をファイル名生成のパターンの一部として扱う。
setopt EXTENDED_GLOB
# 補完リストなるべく少ない行数に
setopt LIST_PACKED
# 補完候補を種別表示(ls -F)
setopt LIST_TYPES
# = 以降も補完 (--prefix=/usr等)
setopt MAGIC_EQUAL_SUBST

##################################################
# オプション設定解除
##################################################
# 全てのバックグラウンドジョブを低優先度で実行
unsetopt BG_NICE
# ZLE
#unsetopt beep

# completion color
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

REPORTTIME=3

# http://uu59.blog103.fc2.com/blog-entry-5.html
autoload bashcompinit
bashcompinit
