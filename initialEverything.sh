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

if [ "$System" == "Darwin" ];then
    echo "=============================================================================="
    echo "==                     step(1/10):xcode & homebrew                          =="
    echo "=============================================================================="
    info "checking if Xcode CommandLineTools is installed"
    if ! xcode-select --print-path &> /dev/null; then
        info "CommandLineTools needs to be install"
        xcode-select --install
        ok "CommandLineTools has installed."
    else
        ok "CommandLineTools has already installed. Nothing need to be done here. "
    fi
    
    info  "Checking if homwbrew is installed"
    if type brew > /dev/null 2>&1; then
        ok "Homwbrew has already installed. Nothing need to be done here. "
    else
        info "Homwbrew needs to be install"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        ok "Homwbrew has installed"
    fi
else
    echo "=============================================================================="
    echo "==                     step(1/10):mirrorlist pacman.conf yay                =="
    echo "=============================================================================="
    
    # sudo sed -i 's/#Color/Color/g' /etc/pacman.conf

    info "linking pacman.conf"
    sudo rm /etc/pacman.conf 
    sudo cp "$DOTFILES/etc/pacman.conf" /etc/pacman.conf
    # ln -sf "$DOTFILES/etc/pacman.conf" /etc/pacman.conf
    # makelink "$DOTFILES/etc/pacman.conf" /etc/pacman.conf

    info "linking mirrorlist"
    # sudo pacman-mirrors -i -c China -m rank
    # makelink "$DOTFILES/etc/mirrorlist" /etc/pacman.d/mirrorlist
    sudo rm /etc/pacman.d/mirrorlist 
    sudo cp "$DOTFILES/etc/mirrorlist" /etc/pacman.d/mirrorlist
    # ln -sf "$DOTFILES/etc/mirrorlist" /etc/pacman.d/mirrorlist
    
    info "sync&refresh database"
    sudo pacman -Syyuu --noconfirm 

    info "install base tools: base-devel git curl wget yay"
    sudo pacman -S --needed --noconfirm archlinuxcn-keyring archlinuxcn-mirrorlist-git 
    sudo pacman -S --needed --noconfirm base-devel git curl wget yay

    info "config IME(input method editor)"
    sudo pacman -S --needed --noconfirm fcitx-im fcitx-configtool fcitx-googlepinyin
    makelink "$DOTFILES/linux/.xprofile" ~/.xprofile

    # info "checking yay (aur helper)..."
    # if test "$(command -v yay)"; then
    #     ok "yay has already installed"
    # else
    #     info "yay needs to be installed"
    #     git clone https://aur.archlinux.org/yay.git ~/tmpyay
    #     cd ~/tmpyay
    #     makepkg -si --noconfirm
    #     cd - > /dev/null 2>&1
    #     rm -rf ~/tmpyay
    #     ok "yay has installed"
    # fi

    info "update system..."
    # --ignore=fcitx-sogoupinyin
    sudo pacman -Syyuu --noconfirm 
    ok "done"
fi


echo "=============================================================================="
echo "==                     step(2/10):install softwares                         =="
echo "=============================================================================="
if [ "$System" == "Darwin" ];then
    # brew bundle -v --file="$dotfile_path"/packages/Brewfile
    info "preparing..."
    brew update
    brew bundle -v
    ok "done"
else
    info "preparing..."
    sudo pacman -S --needed --noconfirm $(cat "$DOTFILES/pacman_pkglist"|xargs)
    yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
    yay -S --needed --noconfirm $(cat "$DOTFILES/aur_pkglist"|xargs)

    # info "config jdk..."
    # sudo pacman -S --needed jdk8
    # sudo archlinux-java set java-8-jdk

    ok "done"
fi


echo "=============================================================================="
echo "==                     step(3/10):update system configuration               =="
echo "=============================================================================="
# read -r -p "modify system config??? [y|N] " response
# if [[ $response =~ (yes|y|Y) ]];then
#     if [ "$System" == "Darwin" ];then
#         sh ./mac/macos_preferences.sh
#         sudo spctl --master-disable
#         ok "Mac system config has been updated"
#     else
#         sh ./linux/manjaro_preferences.sh
#         ok "Linux system config has been updated"
#     fi
# else
#     ok "skipped system config"
# fi
info "making working space dir"
info "create $HOME/dev "
mkdir -p "$HOME/dev"
info "create $HOME/dev/android/sdk "
mkdir -p "$HOME/dev/android/sdk"
info "create $HOME/doc "
mkdir -p "$HOME/doc"
info "create $HOME/todo "
mkdir -p "$HOME/todo"
info "create $HOME/mrepo "
mkdir -p "$HOME/mrepo"
info "create $HOME/mrepo/github "
mkdir -p "$HOME/mrepo/github"
ok "working space dir been updated"
info "linking bin"
makelink "$DOTFILES"/bin ~/bin
info "linking bak"
makelink "$DOTFILES"/bak ~/bak
ok "done"


echo "=============================================================================="
echo "==                     step(4/10):config git                                =="
echo "=============================================================================="
if type git > /dev/null 2>&1; then
    ok "git has already installed"
else
    info  "Installing git"
    if [ "$System" == "Darwin" ];then
        brew install git
    else
        sudo pacman -S --needed --noconfirm git
    fi
    ok "done"
fi
info "linking gitconfig"
makelink "$DOTFILES/git/.gitconfig" ~/.gitconfig
info "linking git_commit_template"
makelink "$DOTFILES/git/git_commit_template.txt" ~/.git_commit_template.txt
info "linking global_gitignore"
makelink "$DOTFILES/git/.global_gitignore" ~/.global_gitignore
info "linking sub folder gitconfig"
makelink "$DOTFILES/mrepo/github/.gitconfig" ~/mrepo/github/.gitconfig
ok "done"


if [ "$(uname -s)" = "Darwin" ]; then
    echo "=============================================================================="
    echo "==                     step(5/10):terminal  zsh antigen  iterm2             =="
    echo "=============================================================================="
    info "config env..."
    brew install zsh antigen
    brew install iterm2
    BREW_ZSH=/usr/local/bin/zsh
    echo "zsh version: $($BREW_ZSH --version)"
    if [[ $SHELL == *"zsh"* ]]; then
        ok "Shell already set to zsh.";
    else
        info "Setting shell to zsh...";
        sudo sh -c "echo $BREW_ZSH >> /etc/shells"
        chsh -s $BREW_ZSH
        ok "default shell has set to $BREW_ZSH"
    fi

    info "config iterm2..."
    # comes from http://stratus3d.com/blog/2015/02/28/sync-iterm2-profile-with-dotfiles-repository/
    # Specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES/iterm2"
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
    ok "done iterm2 config"
    echo "you may need to open iterm2, and set it as the default terminal."
else
    echo "=============================================================================="
    echo "==                     step(5/10):terminal   zsh antigen  terminator        =="
    echo "=============================================================================="
    info "config env..."
    sudo pacman -S --needed --noconfirm zsh terminator
    yay -S --needed --noconfirm antigen-git

    MY_ZSH=/usr/bin/zsh
    echo "zsh version: $($MY_ZSH --version)"
    if [[ $SHELL == *"zsh"* ]]; then
        ok "Shell already set to zsh.";
    else
        info "Setting shell to zsh...";
        chsh -s $MY_ZSH
        ok "default shell has set to $MY_ZSH"
    fi

    info "config terminator"
    sudo pacman -S --needed --noconfirm terminator 
    mkdir -p ~/.config/terminator/
    makelink "$DOTFILES/terminator/config" ~/.config/terminator/config
    ok "done terminator config"
fi
info "linking zshrc"
makelink "$DOTFILES/zsh/.zshrc" ~/.zshrc
ok "done"


echo "=============================================================================="
echo "==                     step(6/10):config anaconda  python env               =="
echo "=============================================================================="
if type conda > /dev/null 2>&1; then
    ok "anaconda has already installed"
else
    info  "Installing anaconda"
    if [ "$System" == "Darwin" ];then
        brew install anaconda
        export PATH=/usr/local/anaconda3/bin:"$PATH"
    else
        sudo pacman -S --needed --noconfirm anaconda
        export PATH="/opt/anaconda/bin:$PATH"
    fi
    ok "anaconda has installed"
fi

if ! conda env list | grep "basicPy36"  ; then
    info "creating basicPy36 env"
    conda create -n basicPy36 -y python=3.6
else
    ok "basicPy36 env has already created"
fi

if ! conda env list | grep "basicPy27" ; then
    info "creating basicPy27 env"
    conda create -n basicPy27 -y python=2.7
else
    ok "basicPy27 env has already created"
fi

info "disable prompt conflict with spaceship prompt"
conda config --set changeps1 False
ok "done"
echo "conda env list"
conda env list


# using zsh plugin instead
# toc "nvm"
# if [[ type nvm > /dev/null 2>&1 ]]; then
#   ok "nvm has already installed"
# else
#   ing  "Installing nvm"
#   curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
#   ok "nvm has installed"
# fi


echo "=============================================================================="
echo "==                     step(7/10):rbenv  ruby env                           =="
echo "=============================================================================="
if type rbenv > /dev/null 2>&1; then
    ok "rbenv has already installed"
else
    info  "Installing rbenv"
    if [ "$System" == "Darwin" ];then
        brew install rbenv
        eval "$(rbenv init -)"
    else
        yay -S --needed --noconfirm rbenv
        export PATH="$HOME/.rbenv/bin:$PATH"
        eval "$(rbenv init -)"
    fi
    # curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
    ok "rbenv has installed"
fi

if [ "$System" == "Darwin" ];then
    info  "Mac installed ruby build using brew"
else
    if [ -d "$(rbenv root)"/plugins/ruby-build ] ; then
        info  "ruby-build has already installed"
    else
        mkdir -p "$(rbenv root)"/plugins
        git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    fi
fi

if ! rbenv versions | grep "2.5.1" ; then
    info "rbenv install 2.5.1"
    rbenv install 2.5.1
else
    ok "rbenv env 2.5.1 has already installed"
fi
echo "rbenv versions"
rbenv versions


echo "=============================================================================="
echo "==                     step(8/10):config vim with vim-plug                  =="
echo "=============================================================================="
info "link config files"
makelink "$DOTFILES/vim/complete.vimrc" ~/.vimrc
ok "done"
info "install vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ok "done"
info "install/update vim plugin"
vim +'PlugInstall --sync' +qa
vim +'PlugUpdate' +qa
ok "done"


echo "=============================================================================="
echo "==                     step(9/10):vscode                                    =="
echo "=============================================================================="
if type code > /dev/null 2>&1; then
    ok "vscode has already installed"
else
    info  "Installing vscode"
    if [ "$System" == "Darwin" ];then
        brew install visual-studio-code
    else
        sudo pacman -S --noconfirm visual-studio-code 
    fi
    ok "vscode has installed"
fi
if test "$(command -v code)"; then
	# from `code --list-extensions`
    # code --list-extensions | xargs -L 1 echo code --install-extension
    info "update vscode plugins"
	echo "yes" | code --install-extension k--kato.intellij-idea-keybindings
    echo "yes" | code --install-extension akamud.vscode-theme-onedark
	echo "yes" | code --install-extension vscode-icons-team.vscode-icons
	echo "yes" | code --install-extension eamodio.gitlens
	echo "yes" | code --install-extension donjayamanne.githistory
    # echo "yes" | code --install-extension yzhang.markdown-all-in-one
    # echo "yes" | code --install-extension joffreykern.markdown-toc
	# echo "yes" | code --install-extension vscjava.vscode-java-pack
	# echo "yes" | code --install-extension ms-python.python
	# echo "yes" | code --install-extension mathiasfrohlich.Kotlin
	# echo "yes" | code --install-extension naco-siren.gradle-language
	# echo "yes" | code --install-extension formulahendry.code-runner
    # echo "yes" | code --install-extension ms-azuretools.vscode-docker

    ok "vscode plugins has updated"

	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi
    info "link config files"
	makelink "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
	makelink "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
    ok "done"
else
    echo "you may need to export code command to your shell env"
fi


echo "=============================================================================="
echo "==                     step(10/10):link other dotfiles                      =="
echo "=============================================================================="
info "linking proxychains"
# makelink "$DOTFILES/proxychains" etc/.proxychains
makelink "$DOTFILES/proxychains" ~/.proxychains
ok "done"

# info "linking SwitchHosts"
# mkdir -p ~/.SwitchHosts
# makelink "$DOTFILES/SwitchHosts/data.json" ~/.SwitchHosts/data.json
# makelink "$DOTFILES/SwitchHosts/preferences.json" ~/.SwitchHosts/preferences.json
# ok "done"


echo ""
echo "=============================================================================="
echo "==                     Congratulations，all done.                           =="
echo "=============================================================================="
