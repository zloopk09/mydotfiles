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
antigen bundle robertzk/sudo.zsh
antigen bundle agkozak/zsh-z
antigen bundle djui/alias-tips
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen theme spaceship-prompt/spaceship-prompt
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

SPACESHIP_VI_MODE_SHOW=false

# google's git-repo tool definition
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'
export ANDROID_HOME="$HOME/dev/android/sdk"

# alias
alias uignore="git rm -r --cached . && git add ."
alias ls="exa"
alias py2="source activate basicPy27"
alias py3="source activate basicPy36"
alias unpy="conda deactivate"
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
alias gp='git a . && git commit -m "update" && git push'
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
alias gd="gradle"
alias gdd="gradle -Dorg.gradle.daemon=false -Dorg.gradle.debug=true"
alias gw="./gradlew"
alias gwr='./gradlew --profile --recompile-scripts --rerun-tasks'
alias gwd='./gradlew -Dorg.gradle.daemon=false -Dorg.gradle.debug=true'
alias drps="docker ps" # -a -q
alias drimg="docker images"
alias drrd="docker run -d -P"
alias drri="docker run -i -t -P"
alias drexe="docker exec -i -t"
alias adbfo="adb shell dumpsys activity | grep mFocused"
# Stop all containers
drst() { docker stop $(docker ps -a -q); }
# Bash into running container
drboard() { docker exec -it $(docker ps -aqf "name=$1") bash; }
# Fire an intent
# Usage: startintent https://twitter.com/nisrulz
alias sint="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X shell am start $1"
# Install Apk
# Usage: apkinstall ~/path/to/apk/App.apk
alias inapp="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X install -r $1"
# Uninstall an app
# Usage: rmapp com.example.demoapp
alias unapp="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X uninstall $1"
# Clear all data of an app
# Usage: clearapp com.example.demoapp
alias clearapp="adb devices | tail -n +2 | cut -sf 1 | xargs -I X adb -s X shell pm clear $1"
alias andmonitor="sh ~/dev/android/sdk/tools/monitor"

eval $(thefuck --alias FUCK)
eval $(thefuck --alias fuck)
eval $(thefuck --alias fxxk)

export PATH=$PATH:$HOME"/dev/android/sdk/platform-tools"

# system specific
if [ "$(uname)" = "Darwin" ]; then
  # copy ssh public key
  alias msshkey="pbcopy < ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"

  # python环境切换
  export PATH=/usr/local/anaconda3/bin:"$PATH"

  # brew sbin
  export PATH="/usr/local/sbin:$PATH"

  # 网络环境切换
  alias ss="export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;"
  alias unss='unset http_proxy && unset https_proxy'

  # homebrew command-not-found插件
  if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi
  alias brewup='brew update; brew upgrade; brew cleanup'
  alias opn="open ."

  # java环境切换 默认java8
 export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
 export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
 alias java8='export JAVA_HOME=$JAVA_8_HOME'
 alias java11='export JAVA_HOME=$JAVA_11_HOME'
 export JAVA_HOME=$JAVA_8_HOME
#  export JAVA_HOME=`/usr/bin/java`

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
  alias sysuf="sudo pacman -Syu --overwrite='*'"
  alias teamup="teamviewer --daemon start"
  alias opn="nautilus -s ."

  # rbenv
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # Ctrl-Left and Ctrl-Right keys move between words
  bindkey ";5C" forward-word
  bindkey ";5D" backward-word
fi

# zprof

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/youhuanz/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/youhuanz/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/youhuanz/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/youhuanz/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

