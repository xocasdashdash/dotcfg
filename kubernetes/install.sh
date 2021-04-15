#!/usr/bin/env sh


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

[ ! -d ~/.kubectx ] && git clone git@github.com:ahmetb/kubectx.git ~/.kubectx
cd ~/.kubectx && git pull
chmod +x ~/.kubectx/completion/kubectx.zsh
chmod +x ~/.kubectx/completion/kubens.zsh

ln -sf ~/.kubectx/completion/kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh
ln -sf ~/.kubectx/completion/kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh
