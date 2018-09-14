# Initialize command prompt
# export PS1="%n@%m:%~%# "

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"

# AUTO-UPDATES
export UPDATE_ZSH_DAYS=1

# Load local bash/zsh compatible settings
_INIT_SH_NOFUN=1
[ -f "$HOME/.local/etc/init.sh" ] && source "$HOME/.local/etc/init.sh"

# exit for non-interactive shell
[[ $- != *i* ]] && return

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# pacman -Q antibody || yay -S --needed --noconfirm antibody
source "${HOME}/.zgen/zgen.zsh"

zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found
    zgen load zsh-users/zsh-completions src
    zgen oh-my-zsh plugins/history-substring-search
    zgen load zdharma/fast-syntax-highlighting

zgen load denysdovhan/spaceship-prompt spaceship

# Ctrl-Left and Ctrl-Right keys move between words
bindkey ";5C" forward-word
bindkey ";5D" backward-word

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

# add timestamps to history
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
# adds history
setopt APPEND_HISTORY
# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTFILE=~/.zsh_history
HISTSIZE=1000
HISTFILESIZE=2000


# alias
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
# alias ..="cd .."
# alias ...="cd ../.."
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

