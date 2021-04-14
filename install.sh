#!/usr/bin/env sh

sudo apt install -y zsh git git-crypt gnupg coreutils jq jo ack-grep fzf

grep -e "${USER}.*zsh" /etc/passwd -q || chsh -s "$(which zsh)"
[ ! -d ~/.asdf ] || git clone https://github.com/asdf-vm/asdf.git ~/.asdf
echo 'Install oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -sf "$(pwd)/dotfiles/.zshrc" ~/.zshrc
grep -q asdf ~/.zshrc || echo ". \$HOME/.asdf/asdf.sh" >> ~/.zshrc
dconf load /org/gnome/terminal/legacy/profiles:/ < terminator/config
sudo snap install --classic code

while read -r line; do
code --install-extension "${line}"
done < code/extensions

asdf plugin-add python
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add gradle https://github.com/rfrancis/asdf-gradle.git
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin-add istioctl https://github.com/rafik8/asdf-istioctl.git
asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
asdf plugin-add kind https://github.com/johnlayton/asdf-kind
asdf plugin-add k9s https://github.com/looztra/asdf-k9s
asdf plugin add oc https://github.com/sqtran/asdf-oc.git
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git

mkdir -p ~/.oh-my-zsh/completions
chmod -R 755 ~/.oh-my-zsh/completions
if [ ! -f  ~/bin/kubectx ]; then
curl -L -o /tmp/kubectx https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_x86_64.tar.gz
tar -xvf /tmp/kubectx -C ~/bin/ && rm ~/bin/LICENSE
chmod +x ~/bin/kubectx
rm /tmp/kubectx
fi

if [ ! -f  ~/bin/kubens ]; then
curl -L -o /tmp/kubens https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_x86_64.tar.gz
tar -xvf /tmp/kubens -C ~/bin/ && rm ~/bin/LICENSE
chmod +x ~/bin/kubens
rm /tmp/kubens
fi

git clone git@github.com:ahmetb/kubectx.git ~/.kubectx
chmod +x ~/.kubectx/completion/kubectx.zsh
chmod +x ~/.kubectx/completion/kubens.zsh

ln -sf ~/.kubectx/completion/kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh
ln -sf ~/.kubectx/completion/kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh
