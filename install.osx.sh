#!/usr/bin/env sh

brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install libressl jo htop \
  docker tree git gpg podman gdlib re2c bison autoconf \
  gmp libsodium imagemagick hub sqsmover \
  automake pkg-config pcre xz

brew install --cask firefox
sh dotfiles/install.sh


mkdir -p ~/.oh-my-zsh/completions

sh asdf/install.sh
"$(asdf where fzf)/install" --all
sh iterm/install.sh
sh git/install.sh
