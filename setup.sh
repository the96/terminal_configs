#!/bin/zsh
echo "source `pwd`/zshrc" >> ~/.zshrc
echo "source `pwd`/aliases" >> ~/.zshrc
echo "[include]
	path = `pwd`/gitconfig" >> ~/.gitconfig

echo '=== setup rosetta ==='
sudo softwareupdate --install-rosetta --agree-to-license

echo '=== setup brew ==='
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/the96/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
exec $SHELL

echo '=== install standard software ==='
brew install ripgrep fd gawk gsed

echo '=== setup anyenv ==='
brew install anyenv
anyenv init
anyenv install --init
echo 'export PATH="$HOME/.anyenv/bin:$PATH" >> ~./zshrc'
echo 'eval "$(anyenv init -)"' >> ~/.zshrc

anyenv install plenv
anyenv install rbenv
anyenv install nodenv
exec $SHELL -l

plenv install 5.38.2
plenv global 5.38.2
cpan App::cpanminus
cpanm String::CamelCase

echo '=== setup gh ==='
brew install gh
gh auth login

echo '=== install docker ==='
brew install docker
echo 'install docker compose'
echo 'for mac: https://zenn.dev/redgosho/articles/ee2bd023a946a2'
echo 'https://matsuand.github.io/docs.docker.jp.onthefly/compose/install/'

source ~/.zshrc
