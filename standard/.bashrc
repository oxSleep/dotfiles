#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export EDITOR=nvim
export HISTSIZE=10000
export HISTCONTROL="ignoredups:ignoreboth"
export HISTFILE=${HOME}/.local/state/bash/bash_history
export INPUTRC=${HOME}/.config/readline/inputrc 

alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias la='ls -la --color=auto'
alias adb='HOME="${XDG_DATA_HOME}"/android adb'

if [ -d "$HOME/.local/bin/" ]; then
    export PATH="$HOME/.local/bin/:$PATH"
fi

source $HOME/.local/bin/fzf_cd.sh
bind -x '"\en": fd nvim'
bind -x '"\ef": fd'
bind -x '"\eF": fe nvim'

PS1='[\[\e[32m\]\u\[\e[0m\]@\[\e[35m\]\h\[\e[0m\]][\[\e[38;5;69m\]\w\[\e[0m\]]\\$ '
