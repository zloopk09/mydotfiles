#!/usr/bin/env bash

#=============================================================================
# Script to set up new operation System. 
# Only for mac & manjaro
# please read the source before you using it
#=============================================================================

set -e

cat << "EOF"

    d8888b.  .d88b.  d888888b d88888b d888888b db      d88888b .d8888.
    88  `8D .8P  Y8. `~~88~~' 88'       `88'   88      88'     88'  YP
    88   88 88    88    88    88ooo      88    88      88ooooo `8bo.  
    88   88 88    88    88    88~~~      88    88      88~~~~~   `Y8b.
    88  .8D `8b  d8'    88    88        .88.   88booo. 88.     db   8D
    Y8888D'  `Y88P'     YP    YP      Y888888P Y88888P Y88888P `8888Y'

        warning!!!: please read the source before using it!!!
        warning!!!: please read the source before using it!!!
        warning!!!: please read the source before using it!!!

EOF


Color_off='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

msg() {
  printf '%b\n' "$1" >&2
}

ok() {
  msg "${Green}[✔]${Color_off} ${1}${2}"
}

info() {
  msg "${Yellow}[➜]${Color_off} ${1}${2}"
}

xx() {
  msg "${Red}[✖]${Color_off} ${1}${2}"
}

makelink () {
  local src=$1 dst=$2
  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ] ; then
    rm -rf "$dst"
    info "$dst removed"
  fi
  ln -s "$src" "$dst"
  info "$dst linked"
}

DOTFILES="$( cd "$( dirname "$0" )" && pwd )"

System="$(uname -s)"

echo "current dotfiles path: $DOTFILES"
read -r -p "continune? [y|N] " response
if [[ $response =~ (yes|y|Y) ]];then
    ok "continue..."
else
    xx "abort"
    exit 2
fi

# see https://gist.github.com/cowboy/3118588
# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


info "linking zshrc"
makelink "$DOTFILES/zsh/.zshrcDarwin" ~/.zshrc