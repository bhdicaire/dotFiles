#!/usr/bin/env zsh

# +-----------+
# | FUNCTIONS |
# +-----------+

function zsh_stats() {
  fc -l 1 \
    | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
    | grep -v "./" | sort -nr | head -n 20 | column -c3 -s " " -t | nl
}

# take functions

# mkcd is equivalent to takedir
function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}

function takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

function take() {
  if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}

github-clone-cd() {
  local prefix=https://github.com/
  if [ "$1" = "--ssh" ]; then
    prefix=git@github.com:
    shift
  fi
  local dir="${HOME}/Code/$1"
  if [ ! -d "${dir}" ]; then
    git clone "${prefix}$1.git" "${dir}"
  fi
  cd "${dir}"
}

github-clone-code() {
  local prefix=https://github.com/
  if [ "$1" = "--ssh" ]; then
    prefix=git@github.com:
    shift
  fi
  local dir="${HOME}/Code/$1"
  if [ ! -d "${dir}" ]; then
    git clone "${prefix}$1.git" "${dir}"
  fi
  bbedit "${dir}"
}
