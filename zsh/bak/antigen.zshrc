# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

HIST_STAMPS="mm/dd/yyyy"

# load antigen
if [ "$(uname)" = "Darwin" ]; then
  # Darwin/mac
  source /usr/local/share/antigen/antigen.zsh
else
  # GNU/Linux
  source $HOME/.antigen/antigen.zsh
fi

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# load bundle
# antigen bundle git
# antigen bundle djui/alias-tips
antigen bundle z # autojump
antigen bundle sudo
antigen bundle zsh-users/zsh-autosuggestions # Fish-like suggestions bundle
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Load the theme
# antigen theme robbyrussell
# export DEFAULT_USER=$USER
# antigen theme agnoster
# antigen theme ys
# antigen theme refined
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# Tell antigen that you're done
antigen apply

# Ctrl-Left and Ctrl-Right keys move between words
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# Use vim as the default text editor
export EDITOR=vim

# You may need to manually set your language environment
# export LANG=zh_CN.UTF-8
export LANG=en_US.UTF-8

# autoload color
autoload -U colors && colors

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# alias
alias antigenU="antigen update && antigen cache-gen"
alias py2="source activate py27"
alias py3="source activate py36"
alias dpy2="source deactivate py27"
alias dpy3="source deactivate py36"
alias pc="proxychains4"
alias zshrc="vim ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias gitconfig="vim ~/.gitconfig"
alias ll='ls -la'
alias vi="vim"
alias myip="curl ip.cn"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# system specific
if [ "$(uname)" = "Darwin" ]; then
  # Darwin/mac
  export PATH=/usr/local/anaconda2/bin:"$PATH"
  alias ss="export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;"
  alias dess='unset http_proxy && unset https_proxy'
else
  # GNU/Linux
  # added by Anaconda3 installer
  export PATH="/opt/anaconda3/bin:$PATH"
fi

