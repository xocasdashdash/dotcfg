#!/usr/bin/env sh

brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install autoconf automake
brew install libressl jo htop \
  docker tree git gpg podman re2c bison \
  gmp libsodium imagemagick hub sqsmover \
  pkg-config pcre xz

brew install --cask firefox
sh dotfiles/install.sh


mkdir -p "$HOME/.oh-my-zsh/completions"
mkdir -p "$HOME/.zshrc.d/"

sh asdf/install.sh
sh iterm/install.sh
sh git/install.sh
