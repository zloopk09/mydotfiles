# see https://github.com/rbenv/rbenv/wiki/Unix-shell-initialization
# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Use vim as the default text editor
export EDITOR=vim

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HIST_STAMPS="mm/dd/yyyy"
setopt HIST_IGNORE_ALL_DUPS

# default in oh my zsh 
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh
# HISTSIZE=50000
# SAVEHIST=10000

# DISABLE AUTOCORRECTION
DISABLE_CORRECTION="true"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# autoload color
autoload -U colors && colors

export NVM_LAZY_LOAD=true
# export NVM_NO_USE=true

if [ "$(uname)" = "Darwin" ]; then
  source /usr/local/share/antigen/antigen.zsh
else
  source /usr/share/zsh/share/antigen.zsh
fi

antigen use oh-my-zsh
antigen bundle sudo
antigen bundle z
antigen bundle djui/alias-tips
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen theme denysdovhan/spaceship-prompt
antigen apply

function c256() {
    for k in `seq 0 1`;do 
        for j in `seq $((16+k*18)) 36 $((196+k*18))`;do 
            for i in `seq $j $((j+17))`; do 
                printf "\e[01;$1;38;5;%sm%4s" $i $i;
            done;echo;
        done;
    done
}

# see link: https://github.com/caarlos0/dotfiles/blob/master/zsh/zshrc.symlink
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# google's git-repo tool definition
export REPO_URL='https://github.com/zloopk09/git-repo-mirror'

# alias
alias uignore="git rm -r --cached . && git add ."
alias ls="exa"
alias py2="source activate basicPy27"
alias py3="source activate basicPy36"
alias unpy="source deactivate"
alias py='python'
alias pc="proxychains4"
alias zshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias gitconfig="vim ~/.gitconfig"
alias vimrc="vim ~/.vimrc"
alias ll='ls -la'
alias vi="vim"
alias v="vim"
alias g="git"
alias myip="curl ipinfo.io"
alias hs='history | grep'
alias rm="trash"
alias rbv='rbenv'
alias rbvv='rbenv versions'
alias rbvlist='rbenv install -l'
alias rbvg='rbenv global'
alias rbvl='rbenv local'
alias rbvs='rbenv shell'
alias rbvha='rbenv rehash'
alias mg="python mgit.py"
alias gw="./gradlew"
alias gwb='./gradlew build'
alias gwc='./gradlew clean'
alias drps="docker ps" # -a -q
alias drimg="docker images"
alias drrd="docker run -d -P"
alias drri="docker run -i -t -P"
alias drexe="docker exec -i -t"
# Stop all containers
drst() { docker stop $(docker ps -a -q); }
# Bash into running container
drboard() { docker exec -it $(docker ps -aqf "name=$1") bash; }

eval $(thefuck --alias FUCK)
eval $(thefuck --alias fuck)

# system specific
if [ "$(uname)" = "Darwin" ]; then
  # copy ssh public key
  alias msshkey="pbcopy < ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"

  # python环境切换
  export PATH=/usr/local/anaconda3/bin:"$PATH"

  # 网络环境切换
  alias ss="export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;"
  alias unss='unset http_proxy && unset https_proxy'

  # homebrew command-not-found插件
  if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi
  alias brewup='brew update; brew upgrade; brew prune; brew cleanup'
  alias opn="open ."

  # java环境切换 默认java8
  export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
  export JAVA_10_HOME=$(/usr/libexec/java_home -v10)
  alias java8='export JAVA_HOME=$JAVA_8_HOME'
  alias java10='export JAVA_HOME=$JAVA_10_HOME'
  export JAVA_HOME=$JAVA_8_HOME

  # rbenv
  eval "$(rbenv init -)"

  # misc
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
  
else
  # GNU/Linux
  # copy ssh public key
  alias msshkey="xclip -sel clip < ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"
  # added by Anaconda3 installer
  export PATH="/opt/anaconda/bin:$PATH"

  alias ss="export ALL_PROXY=socks5://127.0.0.1:1080"
  alias unss="unset ALL_PROXY"
  alias sysu="sudo pacman -Syu --noconfirm"
  alias opn="nautilus -s ."

  # rbenv
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # Ctrl-Left and Ctrl-Right keys move between words
  bindkey ";5C" forward-word
  bindkey ";5D" backward-word
fi

# zprof