#!/usr/bin/env sh

sudo apt install -y zsh git git-crypt gnupg coreutils jq jo ack-grep fzf \
htop docker zlib1g-dev build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git xclip bash-completion lastpass-cli \
build-essential cmake libcurl4 libcurl4-openssl-dev libxml2 libxml2-dev libssl1.1 \
pkg-config ca-certificates sshpass pavucontrol v4l-utils tree podman
  

grep -e "${USER}.*zsh" /etc/passwd -q || chsh -s "$(which zsh)"
[ ! -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf
echo 'Install oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -sf "$(pwd)/dotfiles/.zshrc" ~/.zshrc
ln -sf "$(pwd)/dotfiles/001-alias.zsh" ~/.oh-my-zsh/custom/
grep -q asdf ~/.zshrc || echo ". \$HOME/.asdf/asdf.sh" >> ~/.zshrc
dconf load /org/gnome/terminal/legacy/profiles:/ < terminator/config
sudo snap install --classic code
sudo snap install --classic slack
sudo snap install spotify

while read -r line; do
code --install-extension "${line}"
done < code/extensions

sh asdf/install.sh
sh python/install.sh
sh kubernetes/install.sh
sh git/install.sh
sh networking/install.sh