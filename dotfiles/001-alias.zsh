#alias pbcopy='xclip -selection clipboard'
#alias pbpaste='xclip -selection clipboard -o'


function gitcd() {
  cd "$(git rev-parse --show-toplevel || echo ".")/$1"
}

function . {
    if [[ $# -eq 0 ]]; then
        builtin . ~/.zshrc
    else
        builtin . "$@"
    fi
}
