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

fzf_cd()
{
    local dir
    dir=$(
        find . -type d -not -path "*/.*" \
            | fzf --min-height 20 --scheme=path
        ) || return

        builtin cd -- "$dir" 

        # if FZF_CD_CMD is set, exec it
        if [[ -n $FZF_CD_CMD ]]; then
            exec "$FZF_CD_CMD"
        fi
}
bind -x '"\en": FZF_CD_CMD=nvim fzf_cd'
bind -x '"\ef": fzf_cd'

fzf_open_file() {
  local file
  file=$(
    find . -type f -path '*/.*' \
        | fzf --min-height 20 --scheme=path
  ) || return

  exec nvim "$file"
}
bind -x '"\eF": fzf_open_file'

PS1='[\[\e[32m\]\u\[\e[0m\]@\[\e[35m\]\h\[\e[0m\]][\[\e[38;5;69m\]\w\[\e[0m\]]\\$ '
