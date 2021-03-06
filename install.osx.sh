#!/usr/bin/env sh

brew --version || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install libressl jo ack-grep htop \
  docker tree git gpg podman gdlib re2c bison autoconf \
  gmp libsodium imagemagick hub sqsmover
brew install --cask firefox
#grep -e "${USER}.*zsh" /etc/passwd -q || chsh -s "$(which zsh)"
[ -f ~/antigen.zsh ] || curl -L git.io/antigen > ~/antigen.zsh
[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf
echo 'Install oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -sf "$(pwd)/dotfiles/.zshrc" ~/.zshrc
ln -sf "$(pwd)/dotfiles/001-alias.zsh" ~/.oh-my-zsh/custom/
grep -q asdf ~/.zshrc || echo ". \$HOME/.asdf/asdf.sh" >> ~/.zshrc
while read -r line; do
code --install-extension "${line}"
done < code/extensions

mkdir -p ~/.oh-my-zsh/completions

sh asdf/install.sh
"$(asdf where fzf)/install" --all
sh python/install.sh
sh iterm/install.sh
sh git/install.sh
