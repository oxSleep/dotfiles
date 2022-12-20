
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias path_show='echo $PATH | tr ":" "\n"'
alias tmux='tmux -u -2'
alias ipa='ip --brief --color a'
alias ls='exa --icons'
alias la='exa -lah --icons --group-directories-first'
alias dot='/usr/bin/git --git-dir=/home/sleepy/.local/.cfg/ --work-tree=/home/sleepy'

export EDITOR=nvim

export HISTFILE=${HOME}/.local/state/bash/.bash_history
export INPUTRC=${HOME}/.config/readline/inputrc 


if [[ -d "${HOME}/.local/bin" && ! "$PATH:" == *"${HOME}.local/bin"* ]];
then
  PATH="${PATH}:${HOME}.local/bin"
fi


[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
PS1='\[\e[0;92m\][\[\e[0;34m\]\u\[\e[0m\]@\[\e[0;95m\]\h \[\e[0m\]\W\[\e[0;92m\]]\[\e[0;90m\]$ \[\e[0m\]'
