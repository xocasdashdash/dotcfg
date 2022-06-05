#!/usr/bin/env sh

canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")
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
asdf plugin-add terraform 
asdf plugin-add promtool https://github.com/looztra/asdf-promtool
asdf plugin-add nodejs
asdf plugin-add goreleaser https://github.com/kforsthoevel/asdf-goreleaser.git
asdf plugin-add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git
asdf plugin-add just https://github.com/franklad/asdf-just
asdf plugin update just 8f4b5c209ed59f6e3acc600a470b69d68f5d78e1

asdf install golang 1.13.15 1.16.3
asdf install python 3.9.4
asdf install java adoptopenjdk-8.0.282+8
asdf install kubectl 1.21.1
asdf install oc 4.7.7
asdf install terraform 0.14.10
asdf install promtool v2.26.0
asdf install istioctl 1.9.3
asdf install nodejs 16.0.0
asdf install gradle 4.10.3
asdf install goreleaser 0.172.1
asdf install node latest
asdf install github-cli latest
asdf install just latest

ln -sf "$( dirname "${canonical}")/.tool-versions" ~/.tool-versions


## Install completions for some tools
gh completion -s zsh > "${HOME}/.oh-my-zsh/completions/_gh"
