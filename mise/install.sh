#!/usr/bin/env sh

set -e
canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")

mise plugin add git https://gitlab.com/jcaigitlab/asdf-git.git
mise install git@latest
mise use --global git@latest
mise plugin add gradle https://github.com/rfrancis/asdf-gradle.git
mise plugin add istioctl https://github.com/rafik8/asdf-istioctl.git
mise plugin add kubectl https://github.com/Banno/asdf-kubectl.git
mise plugin add kind https://github.com/johnlayton/asdf-kind
mise plugin add k9s https://github.com/looztra/asdf-k9s
mise plugin add rust https://github.com/code-lever/asdf-rust.git
mise plugin add terraform 
mise plugin add promtool https://github.com/xocasdashdash/asdf-promtool
mise plugin add goreleaser https://github.com/kforsthoevel/asdf-goreleaser.git
mise plugin add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git
mise plugin add just https://github.com/franklad/asdf-just
mise plugin update just 8f4b5c209ed59f6e3acc600a470b69d68f5d78e1
mise plugin add gojq
mise plugin add fzf
mise plugin add 1password-cli
mise plugin add awscli
mise plugin add starship
mise plugin add ag
mise plugin add packer
mise plugin add vegeta https://github.com/gr1m0h/asdf-vegeta
mise plugin add starship
mise plugin add amazon-ecr-credential-helper

_install_and_set() {
  set -x
  package="$1"
  version="${2:-latest}"
  mise install "${package}"@"${version}"
  mise use --global "${package}"@"${version}"
  set +x
}
_install_and_set golang 
_install_and_set python 
_install_and_set java adoptopenjdk-11.0.24+8
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
_install_and_set amazon-ecr-credential-helper 0.6.0

unset -f _install_and_set

# configure 1password cli to the expected location in order to get it to work.
# codesign -d --entitlements - /Applications/1Password.app/Contents/Library/LoginItems/1Password\ Launcher.app
currentOpPath=$(mise which op)
echo "moving the 1password cli to the expected location"
set -x
sudo mkdir -p /usr/local/Cellar/
sudo mv "${currentOpPath}" /usr/local/Cellar/onepasswordcli
rm "${currentOpPath}"
ln -s /usr/local/Cellar/onepasswordcli "${currentOpPath}"
set +x

## Install completions for some tools
gh completion -s zsh > "${HOME}/.oh-my-zsh/completions/_gh"

# ## This is a hack to improve speed 
# ## https://github.com/asdf-vm/asdf/issues/290
# set -e
# if [ ! -d  /tmp/asdf-exec ]; then git clone git@github.com:xocasdashdash/asdf-exec.git /tmp/asdf-exec; fi;
# cd /tmp/asdf-exec && make macos && cp build/asdf-exec-darwin ~/.asdf/bin/private/asdf-exec && cd -;
# chmod +x  ~/.asdf/bin/private/asdf-exec
# ## This line is very sensible to changes, verify it in case of any issue.
# sed -i.bak -e 's|exec $(asdf_dir)/bin/asdf exec|exec $(asdf_dir)/bin/private/asdf-exec|' ~/.asdf/lib/commands/reshim.bash
# find  ~/.asdf/shims  -type f -exec rm {} \;
# asdf reshim
# rm -rf /tmp/asdf-exec


"$(mise which fzf)/install" --all
