zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# autoload color
autoload -U colors && colors

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi


export ZPLUG_HOME=$HOME/.zplug
local zplug_init=$ZPLUG_HOME/init.zsh
if [ ! -f "$zplug_init" ] &> /dev/null; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
source $zplug_init

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "zsh-users/zsh-history-substring-search", defer:3
# zplug "rupa/z", use:z.sh
# zplug "plugins/autojump",   from:oh-my-zsh
zplug "wting/autojump", use:"bin/autojump", as:command
zplug "wting/autojump", use:"bin/autojump.zsh"
zplug "plugins/git",  from:oh-my-zsh, as:plugin
zplug "plugins/sudo",  from:oh-my-zsh, as:plugin
zplug "djui/alias-tips"
zplug "lib/history", from:oh-my-zsh
if zplug check 'lib/history'; then
    export HIST_STAMPS="mm/dd/yyyy"
fi
zplug "lib/key-bindings", from:oh-my-zsh
# zplug "lib/misc", from:oh-my-zsh
# zplug "lib/directories", from:oh-my-zsh
# zplug "lib/compfix", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

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
fi

