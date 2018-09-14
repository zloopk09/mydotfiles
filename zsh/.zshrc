# see https://github.com/rbenv/rbenv/wiki/Unix-shell-initialization
# zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Use vim as the default text editor
export EDITOR=vim

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HIST_STAMPS="mm/dd/yyyy"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST

# DISABLE AUTOCORRECTION
DISABLE_CORRECTION="true"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# autoload color
autoload -U colors && colors

export NVM_LAZY_LOAD=true
# export NVM_NO_USE=true

# antibody dynamic load
# load oh-my-zsh properly, see https://github.com/getantibody/antibody/issues/218
# ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
source <(antibody init)
# antibody bundle < ~/.antibody.txt

antibody bundle rupa/z
antibody bundle djui/alias-tips

antibody bundle robbyrussell/oh-my-zsh folder:lib
antibody bundle robbyrussell/oh-my-zsh folder:plugins/sudo

antibody bundle zsh-users/zsh-completions
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle lukechilds/zsh-nvm

# these should be at last!
antibody bundle denysdovhan/spaceship-prompt
# antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-history-substring-search

# antibody static load
# terminal run 
# antibody bundle < ~/.antibody.txt > ~/.zsh_plugins.sh
# to generate file, then zshrc using
# source ~/.zsh_plugins.sh

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
alias ls="exa"
alias py2="source activate basicPy27"
alias py3="source activate basicPy36"
alias unpy="source deactivate"
alias py='python'
alias pc="proxychains4"
alias zshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias gitconfig="vim ~/.gitconfig"
alias ll='ls -la'
alias vi="vim"
alias v="vim"
alias g="git"
alias myip="curl ip.cn"
alias hs='history | grep'
alias rm="trash"
alias rbv='rbenv'
alias rbvv='rbenv versions'
alias rbvlist='rbenv install -l'
alias rbvg='rbenv global'
alias rbvl='rbenv local'
alias rbvs='rbenv shell'
alias rbvha='rbenv rehash'
alias ga='git add'
alias gc='git commit -v'
alias gcm='g commit -m'
alias gpl='git pull'
alias gph='git push'
alias gd='git diff'
alias gco='git checkout'
alias gsb='git submodule'
alias gst='git subtree'
alias gsbu="git submodule foreach 'git checkout master; git pull'"
alias gl="g log --graph --pretty=format:'%Cblue%h%Creset%d %Cgreen%an%Creset: %s %Cblue%ar%Creset'"
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
  alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

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

  # rbenv
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # Ctrl-Left and Ctrl-Right keys move between words
  bindkey ";5C" forward-word
  bindkey ";5D" backward-word
fi

# zprof
