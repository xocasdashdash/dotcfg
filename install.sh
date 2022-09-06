#!/usr/bin/env sh

sudo apt install -y zsh git-crypt gnupg coreutils jo ack-grep fzf \
htop docker zlib1g-dev build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git xclip bash-completion lastpass-cli \
build-essential cmake libcurl4 libcurl4-openssl-dev libxml2 libxml2-dev libssl1.1 \
pkg-config ca-certificates sshpass pavucontrol v4l-utils tree podman
  

sh dotfiles/install.sh
dconf load /org/gnome/terminal/legacy/profiles:/ < terminator/config
sudo snap install --classic code
sudo snap install --classic slack
sudo snap install spotify


mkdir -p ~/.oh-my-zsh/completions

sh asdf/install.sh
"$(asdf where fzf)/install" --all
sh kubernetes/install.sh
sh git/install.sh
sh networking/install.sh
