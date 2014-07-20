# Put this in your ~/.(bash|zsh|*)rc file
# Usage: apm bundle
# For an example Atomfile, look here: https://github.com/bahlo/dotfiles/tree/master/atom.symlink
function apm() {
  REAL_APM="/usr/local/bin/apm"

  if [[ $# -eq 0 ]]; then
    $REAL_APM $1
    echo "<command> can also be bundle."
    echo
  elif [[ $1 == "bundle" ]]; then
    if [[ -f "Atomfile" ]]; then
      while read line; do
        if [[ ! -z $line ]]; then
	  echo $REAL_APM $line
          `$REAL_APM $line`
        fi
      done < Atomfile
    else
      echo "Cannot find Atomfile in current directory"
    fi
  else
    $REAL_APM $1
  fi
}
