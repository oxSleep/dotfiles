#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

export GNUPGHOME=${XDG_DATA_HOME}/gnupg
export XCURSOR_PATH=${XDG_DATA_HOME}/icons
export CUDA_CACHE_PATH=${XDG_CACHE_HOME}/nv
export XAUTHORITY=${XDG_RUNTIME_DIR}/Xauthority
export WINEPREFIX=${XDG_DATA_HOME}/wine/default/
export OLLAMA_MODELS=${XDG_DATA_HOME}/ollama/models 
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
export ANDROID_USER_HOME=${XDG_DATA_HOME}
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc":"$XDG_CONFIG_HOME/gtk-2.0/gtkrc.mine"
