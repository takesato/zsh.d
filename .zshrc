autoload -Uz compinit;compinit -u
autoload colors

function init-loader(){
  init_dir=${1:?"You have to specify a directory"}
  for config_file in $init_dir/*.zsh; do
    if [ ! -r $config_file.zwc ]; then
      zcompile $config_file
    elif [ $config_file -nt $config_file.zwc ]; then
      zcompile $config_file
    fi
    source $config_file
  done
  return
}
if [ -e ~/.zsh.d/$HOST ];then
  source ~/.zsh.d/$HOST
fi
init-loader $ZDOTDIR/inits
