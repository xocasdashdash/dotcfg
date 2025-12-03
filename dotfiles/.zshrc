# 1. Load zprof for debugging
# zmodload zsh/zprof
# 2. Zgenom Setup
# Force disable autoupdates to kill the 2.4s lag
export ZGEN_AUTOLOAD_COMPINIT=0 
[[ -e ${ZDOTDIR:-~}/.zgenom ]] || git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
source "${HOME}/.zgenom/zgenom.zsh"

# 3. Zsh Options
setopt histignorealldups sharehistory
bindkey -e
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
ZSH_THEME="robbyrussell"

# 4. Environment
export MANPATH="/usr/local/man:$MANPATH"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Path
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/libressl/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
# Use Shims (Fast) instead of Activate (Slow)
export PATH="$HOME/.local/share/mise/shims:$PATH"

(( $+functions[add-zsh-hook] )) || autoload -Uz add-zsh-hook

# 5. Optimized Fragment Loader
function load-shell-fragments() {
  local dir="$1"
  [[ -d "$dir" ]] || return
  for fragment in "$dir"/*(N.); do
    [[ -r "$fragment" ]] && source "$fragment"
  done
}
load-shell-fragments ~/.zshrc.d

# 6. Plugin Configuration
setup-zgen-repos() {
  echo "--- REBUILDING ZGENOM (This should only happen once) ---"
  
  zgenom ohmyzsh
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/docker
  zgenom ohmyzsh plugins/dotenv
  zgenom ohmyzsh plugins/pip
  zgenom ohmyzsh plugins/command-not-found
  zgenom ohmyzsh plugins/gitfast
  
  zgenom load zsh-users/zsh-completions src
  # zgenom load dbz/kube-aliases
  zgenom load unixorn/fzf-zsh-plugin
  zgenom load unixorn/1password-op.plugin.zsh
  # zgenom load srijanshetty/docker-zsh
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load dbz/kube-aliases src
  zgenom load agkozak/zsh-z
  zgenom load zdharma-continuum/fast-syntax-highlighting

  if [[ $(uname) == "Darwin" ]]; then
    zgenom oh-my-zsh plugins/brew
    zgenom oh-my-zsh plugins/macos
  fi

  # Explicitly save the file
  zgenom save
  echo "--- ZGENOM SAVED ---"
}

# Only run the heavy setup if the static file is missing
if ! zgenom saved; then
  setup-zgen-repos
fi


# 8. Post-Load Config
ZSH_DISABLE_COMPFIX=true
fpath+=~/.zshrc-completions.d
NEWLINE=$'\n'
TAB=$'  '
[ -f ${HOME}/.env ] && . ${HOME}/.env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 7. Manual Compinit (Optimized)
# We disabled ZGEN_AUTOLOAD_COMPINIT above so we can run it faster here
# -C skips security checks (faster)
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  set -x
  compinit -i
  set +x
fi


export EDITOR='code --wait -n'
export VISUAL_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR

# Bash compat
autoload -U +X bashcompinit && bashcompinit


# AWS
complete -C '$(which aws_completer)' aws
complete -C '$(which gs)' gs
# PNPM
export PNPM_HOME="/Users/joaquin.campo/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# This is to disable the telemetry of the tools I use
export OTEL_LOGS_EXPORTER=none
export OTEL_TRACES_EXPORTER=none
export OTEL_METRICS_EXPORTER=none


# Prompt
eval "$(starship init zsh)"

# PHP
export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.2/sbin:$PATH"

# zprof
