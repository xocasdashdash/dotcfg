#!/usr/bin/env sh

canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")

pip install -r "$(dirname "${canonical}")/requirements.txt"

asdf reshim python