# zmodload zsh/zprof
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/dev/android/sdk/platform-tools
# Use vim as the default text editor
export EDITOR=vim

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HIST_STAMPS="mm/dd/yyyy"
setopt HIST_IGNORE_ALL_DUPS

# DISABLE AUTOCORRECTION
DISABLE_CORRECTION="true"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# autoload color
autoload -U colors && colors

if [ "$(uname)" = "Darwin" ]; then
  source /usr/local/share/antigen/antigen.zsh
else
  source /usr/share/zsh/share/antigen.zsh
fi

antigen use oh-my-zsh
antigen bundle robertzk/sudo.zsh
antigen bundle agkozak/zsh-z
antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen theme spaceship-prompt/spaceship-prompt
antigen apply


SPACESHIP_VI_MODE_SHOW=false

# google's git-repo tool definition
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'
export ANDROID_HOME="$HOME/dev/android/sdk"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# alias
alias updateignore="git rm -r --cached . && git add ."
alias ls="exa"
alias py2="conda activate py2"
alias py3="conda activate py3"
alias unpy="conda deactivate"
alias py='python'
alias zshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias gitconfig="vim ~/.gitconfig"
alias vimrc="vim ~/.vimrc"
alias ll='ls -la'
alias vi="vim"
alias v="vim"
alias g="git"
alias gacp='git a . && git commit -m "update" && git push'
alias myip="curl ipinfo.io"
alias hs='history | grep'
alias rm="trash"
alias gd="gradle"
alias gdd="gradle -Dorg.gradle.daemon=false -Dorg.gradle.debug=true"
alias gw="./gradlew"
alias gwr='./gradlew --profile --recompile-scripts --rerun-tasks'
alias gwd='./gradlew -Dorg.gradle.daemon=false -Dorg.gradle.debug=true'
alias dr="docker"
alias adbfocus="adb shell dumpsys activity | grep mFocused"

export PATH=$PATH:$HOME/.fvm/default/bin
# system specific
if [ "$(uname)" = "Darwin" ]; then
  # copy ssh public key
  alias msshkey="pbcopy < ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"

  # 网络环境切换
  alias ss="export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;"
  alias unss='unset http_proxy && unset https_proxy'

  alias brewup='brew update; brew upgrade; brew cleanup'
  alias opn="open ."

  # java环境切换 默认java8
 export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
 export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
 export JAVA_17_HOME=$(/usr/libexec/java_home -v17)
 alias java8='export JAVA_HOME=$JAVA_8_HOME'
 alias java11='export JAVA_HOME=$JAVA_11_HOME'
 alias java17='export JAVA_HOME=$JAVA_17_HOME'
 export JAVA_HOME=$JAVA_11_HOME
#  export JAVA_HOME=`/usr/bin/java`
  
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

  # Ctrl-Left and Ctrl-Right keys move between words
  bindkey ";5C" forward-word
  bindkey ";5D" backward-word
fi

# zprof