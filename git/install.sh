#!/usr/bin/env sh
canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")


ln -sf "$(dirname "${canonical}")/.gitconfig" ~/.gitconfig
ln -sf "$(dirname "${canonical}")/.gitignore_global" ~/.gitignore_global

