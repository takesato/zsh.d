# From https://github.com/fujimura/dotfiles/blob/master/.zshrc.prompt
# From http://d.hatena.ne.jp/mollifier/20090814/p1

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' actionformats '%b|%a'

# http://d.hatena.ne.jp/hirose31/20090703/1246619720
__git_reminder() {
  [ "$(git rev-parse --show-toplevel 2>&1|grep 'Not a git repository')" ] && return
  M=
  git status | grep -q '^nothing to commit' 2>/dev/null || M=$M'*'
  [ ! -z "$(git log --pretty=oneline  origin..HEAD 2>/dev/null)" ] && M=$M'^'
  echo -n "$M"
}

# http://qiita.com/items/13f85c11d3d0aa35d7ef
git_prompt_stash_count () {
  local COUNT=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  if [ "$COUNT" -gt 0 ]; then
    echo " ($COUNT)"
  fi
}

precmd () {

  # Set git info into 1v
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

  setopt prompt_subst
  # PROMPT='%{^[[32m%}%B%U%n@%m%#%{^[[m%}%u%b '
  # RPROMPT='%{^[[32m%}%B[%d]%{^[[m%}%b'
  # SPROMPT='%{^[[33m%} %BCurrenct> '\''%r'\'' [Yes, No, Abort, Edit]%{^[[m%}%b '
  # Define prompt with new color at each prompt
  # See: http://zsh.sourceforge.net/Doc/Release/Functions.html#index-precmd
  #RVM=$(rvm current)
  RPROMPT=$'%{\e[01m%}%{\e[31m%}⣿%d⣿%{\e[m%}'

  #if [ $TERM = "screen-256color" ]; then
  #  #1="$1 " # deprecated.
  #  #echo -ne "\ek${${(s: :)1}[0]}\e\\"
  #  echo -ne "\ek`pwd`\e\\"
  #fi
  #RVM=`rbenv gemset active 2>&1`
  RVM=`rprompt-git-current-branch`
}

PROMPT=$'%B%{\e[32m%}[%*][%(!.#.)%f%1(v|%1v%f|)%{\e[31m%}\$(__git_reminder)|%{\e[m%}$RVM%{\e[32m%}]%b%{\e[m%} %(#.#.$) '
SPROMPT="%B%F{256}%K{200}%r ? %f%k%}%b n,y,a,e :"

#setopt prompt_subst
#RPROMPT='%{${fg[green]}%}%/%{$reset_color%}'
#common_precmd() {
#    LANG=en_US.UTF-8 vcs_info
#    LOADAVG=$(sysctl -n vm.loadavg | perl -anpe '$_=$F[1]')
#    PROMPT='${vcs_info_msg_0_}%{${fg[yellow]}%}%* ($LOADAVG) %%%{$reset_color%} '
#}
#case $TERM in
#    screen)
#        preexec() {
#            echo -ne "\ek$1\e\\"
#        }
#        precmd() {
#            echo -ne "\ek$(basename $SHELL)\e\\"
#            common_precmd
#        }
#        ;;
#    *)
#        precmd() {
#            common_precmd
#        }
#        ;;
#esac


#typeset -ga chpwd_functions
# 
#function _naverc_check() {
#if [[ -f '.naverc' ]] ; then
#  source '.naverc'
#fi
#}
#chpwd_functions+=_naverc_check

# http://memo.officebrook.net/20100204.html
# function chpwd() { ls }
#typeset -ga chpwd_functions
# 
#function _toriaezu_ls() {
#ls -v -F --color=auto
#}
# 
#function _change_rprompt {
#if [ $PWD = $HOME ]; then
#  RPROMPT="[%T]"
#else
#  RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[cyan]%}%60<..<%~%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"
#fi
#}
# 
#chpwd_functions+=_toriaezu_ls
#chpwd_functions+=_change_rprompt

# http://qiita.com/items/13f85c11d3d0aa35d7ef
rprompt-git-current-branch() {
  local name st color action

  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi

  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=${fg[blue]}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=${fg[yellow]}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=${fg_bold[red]}
  else
    color=${fg[red]}
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  # %{...%} surrounds escape string
  echo "%{$color%}$name$action`git_prompt_stash_count`$color%{$reset_color%}"
}