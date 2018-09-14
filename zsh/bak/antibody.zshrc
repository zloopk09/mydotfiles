# zmodload zsh/zprof

export DOTFILES="$HOME/.mydotfiles"
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Use vim as the default text editor
export EDITOR=vim

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HIST_STAMPS="mm/dd/yyyy"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# DISABLE AUTOCORRECTION
DISABLE_CORRECTION="true"
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# autoload color
autoload -U colors && colors

# export NVM_LAZY_LOAD=true
# export NVM_NO_USE=true

# antibody dynamic load
source <(antibody init)
antibody bundle < $DOTFILES/zsh/antibody.txt

# antibody static load
# terminal run 
# antibody bundle < $DOTFILES/zsh/antibody.txt > ~/.zsh_plugins.sh
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

# see https://nick-tomlin.com/2018/03/10/speeding-up-zsh-loading-times-by-lazily-loading-nvm/
# lazy load nvm to speed up zsh start up time
function nvmlazy () {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"  # This loads nvm zsh_completion
}
nvmrclazy() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    if ! type nvm >/dev/null; then
      nvmlazy
    fi
    nvm use
  fi
}
add-zsh-hook chpwd nvmrclazy


# alias
alias ls="exa"
alias py2="source activate basicPy27"
alias py3="source activate basicPy36"
alias dpy2="source deactivate basicPy27"
alias dpy3="source deactivate basicPy36"
alias pc="proxychains4"
alias zshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias gitconfig="vim ~/.gitconfig"
alias ll='ls -la'
alias vi="vim"
alias v="vim"
alias g="git"
alias myip="curl ip.cn"
alias hs='history | grep'
alias rm="trash"

eval $(thefuck --alias FUCK)
eval $(thefuck --alias fuck)

# system specific
if [ "$(uname)" = "Darwin" ]; then
  # copy ssh public key
  alias mysshkey="pbcopy < ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"

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
  alias mysshkey="xclip -sel clip < ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"

  # rbenv
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  # Ctrl-Left and Ctrl-Right keys move between words
  bindkey ";5C" forward-word
  bindkey ";5D" backward-word
fi

# zprof