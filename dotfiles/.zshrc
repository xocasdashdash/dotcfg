# Set up the prompt
DISABLE_AUTO_UPDATE="true"
#zmodload zsh/zprof
[[ -e ${ZDOTDIR:-~}/.zgenom ]] || git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"

source "${HOME}/.zgenom/zgenom.zsh"
# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 10000000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# load add-zsh-hook if it's not available yet
(( $+functions[add-zsh-hook] )) || autoload -Uz add-zsh-hook

# Configure path
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/libressl/bin:$PATH"
export PATH="$HOME/.asdf/shims:$PATH"
export PATH="${PATH}:$HOME/bin"

# . $HOME/.asdf/asdf.sh
eval "$(rtx activate zsh)" && _rtx_hook
PYTHON_BIN_PATH=$(dirname $(which python))
export PATH="${PYTHON_BIN_PATH}:${PATH}"
unset PYTHON_BIN_PATH
# We need to load shell fragment files often enough to make it a function
function load-shell-fragments() {
  if [[ -z $1 ]]; then
    echo "You must give load-shell-fragments a directory path"
  else
    if [[ -d "$1" ]]; then
      if [ -n "$(/bin/ls -A $1)" ]; then
        for _zqs_fragment in $(/bin/ls -A $1)
        do
          if [ -r $1/$_zqs_fragment ]; then
            source $1/$_zqs_fragment
          fi
        done
        unset _zqs_fragment
      fi
    else
      echo "$1 is not a directory"
    fi
  fi
}
# Make it easy to append your own customizations that override the
# quickstart's defaults by loading all files from the ~/.zshrc.d directory
load-shell-fragments ~/.zshrc.d
ZSH_DISABLE_COMPFIX=true
fpath+=~/.zshrc-completions.d
setup-zgen-repos() {
  zgenom ohmyzsh
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/docker
  zgenom ohmyzsh plugins/dotenv
  zgenom ohmyzsh plugins/pip
  zgenom ohmyzsh plugins/lein
  zgenom ohmyzsh plugins/command-not-found
  zgenom load zsh-users/zsh-completions src
  zgenom load unixorn/autoupdate-zgenom
  zgenom load unixorn/fzf-zsh-plugin
  zgenom load unixorn/1password-op.plugin.zsh
  zgenom load srijanshetty/docker-zsh
  zgenom load zdharma-continuum/fast-syntax-highlighting
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load dbz/kube-aliases src
  zgenom load agkozak/zsh-z
  if [ $(uname -a | grep -ci Darwin) = 1 ]; then
    # Load macOS-specific plugins
  zgenom oh-my-zsh plugins/brew
    zgenom oh-my-zsh plugins/macos
  fi
  zgenom save
}

if ! zgenom saved; then
  setup-zgen-repos
fi

NEWLINE=$'\n'
TAB=$'  '
[ -f ${HOME}/.env ] && . ${HOME}/.env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export EDITOR='code --wait -n'
#zprof
eval "$(starship init zsh)"
