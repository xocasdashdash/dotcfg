#!/usr/bin/env sh

canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")
asdf plugin-add git
asdf install git latest
asdf global git latest

asdf plugin-add python
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add gradle https://github.com/rfrancis/asdf-gradle.git
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin-add istioctl https://github.com/rafik8/asdf-istioctl.git
asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
asdf plugin-add kind https://github.com/johnlayton/asdf-kind
asdf plugin-add k9s https://github.com/looztra/asdf-k9s
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf plugin-add terraform 
asdf plugin-add promtool https://github.com/xocasdashdash/asdf-promtool
asdf plugin-add nodejs
asdf plugin-add goreleaser https://github.com/kforsthoevel/asdf-goreleaser.git
asdf plugin-add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git
asdf plugin-add just https://github.com/franklad/asdf-just
asdf plugin update just 8f4b5c209ed59f6e3acc600a470b69d68f5d78e1
asdf plugin-add gojq
asdf plugin-add fzf
asdf plugin add 1password-cli
asdf plugin add awscli
asdf plugin add starship
asdf plugin add ag
asdf plugin add packer

_install_and_set() {
  set -x
  package="$1"
  version="${2:-latest}"
  asdf install "${package}" "${version}"
  asdf global "${package}" "${version}"
  set +x
}
_install_and_set golang 
_install_and_set python 
_install_and_set java adoptopenjdk-8.0.282+8
_install_and_set kubectl 
_install_and_set terraform
_install_and_set packer
_install_and_set promtool 
_install_and_set istioctl 
_install_and_set nodejs 
_install_and_set gradle 
_install_and_set goreleaser 
_install_and_set node 
_install_and_set github-cli 
_install_and_set just 
_install_and_set gojq 
_install_and_set fzf 
_install_and_set 1password-cli 
_install_and_set awscli 
_install_and_set starship 
_install_and_set ag 
_install_and_set php 8.1.17
_install_and_set amazon-ecr-credential-helper 0.6.0

unset -f _install_and_set

# configure 1password cli to the expected location in order to get it to work.
# codesign -d --entitlements - /Applications/1Password.app/Contents/Library/LoginItems/1Password\ Launcher.app
currentOpPath=$(asdf which op)
sudo mv "${currentOpPath}" /usr/local/Cellar/onepasswordcli
rm "${currentOpPath}"
ln -s /usr/local/Cellar/onepasswordcli "${currentOpPath}"


## Install completions for some tools
gh completion -s zsh > "${HOME}/.oh-my-zsh/completions/_gh"

## This is a hack to improve speed 
## https://github.com/asdf-vm/asdf/issues/290
set -e
if [ ! -d  /tmp/asdf-exec ]; then git clone git@github.com:xocasdashdash/asdf-exec.git /tmp/asdf-exec; fi;
cd /tmp/asdf-exec && make macos && cp build/asdf-exec-darwin ~/.asdf/bin/private/asdf-exec && cd -;
chmod +x  ~/.asdf/bin/private/asdf-exec
## This line is very sensible to changes, verify it in case of any issue.
sed -i.bak -e 's|exec $(asdf_dir)/bin/asdf exec|exec $(asdf_dir)/bin/private/asdf-exec|' ~/.asdf/lib/commands/reshim.bash
find  ~/.asdf/shims  -type f -exec rm {} \;
asdf reshim
rm -rf /tmp/asdf-exec


"$(asdf where fzf)/install" --all
