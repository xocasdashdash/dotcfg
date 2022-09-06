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
alias jq=gojq
alias k=kubectl
alias yq="gojq --yaml-input"
alias ack=ag
alias psql="docker run --rm --entrypoint psql -it postgres:14.3-alpine3.16"
alias psql143="docker run --rm --entrypoint psql -it postgres:14.3-alpine3.16"
alias mysql=mysql