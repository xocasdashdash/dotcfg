#!/usr/bin/env bash

grep -e "${USER}.*zsh" /etc/passwd -q || chsh -s "$(which zsh)"
[ -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf
mkdir -p "${HOME}/.zshrc.d"
ln -sf "$(pwd)/dotfiles/001-alias.zsh"  "${HOME}/.zshrc.d/"
ln -sf "$(pwd)/dotfiles/.zshrc" ~/.zshrc
grep -q asdf ~/.zshrc || echo ". \$HOME/.asdf/asdf.sh" >> ~/.zshrc


FIRA_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
mkdir -p ~/.fonts
[ -f ~/.fonts/fira ] || (curl -L -o ~/.fonts/FiraCode.zip $FIRA_FONT_URL && unzip -d ~/Library/Fonts/ ~/.fonts/FiraCode.zip && touch ~/.fonts/fira)
JETBRAINS_FONT_URL="https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip"
[ -f ~/.fonts/jetbrains ] || (curl -L -o ~/.fonts/JetBrains.zip $JETBRAINS_FONT_URL && unzip -d ~/Library/Fonts ~/.fonts/JetBrains.zip && touch ~/.fonts/jetbrains)

mkdir -p ~/.config
[ -f ~/.config/starship.toml ] || ln -s "$(pwd)/dotfiles/starship.toml" ~/.config/starship.toml