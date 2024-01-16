#!/bin/zsh
echo "source `pwd`/zshrc" >> ~/.zshrc
echo "source `pwd`/aliases" >> ~/.zshrc
echo "[include]
	path = `pwd`/gitaliases" >> ~/.gitconfig

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
echo 'eval "$(anyenv init -)"' >> ~/.zshrc

anyenv install plenv
anyenv install rbenv
anyenv install nodenv
exec $SHELL -l

echo '=== install docker and colima ==='
brew install docker colima
echo 'colima config file > $HOME/.colima/default/colima.yaml'
echo 'start and edit config file > `colima start --edit`'
echo 'install docker compose'
echo 'for mac: https://zenn.dev/redgosho/articles/ee2bd023a946a2'
echo 'https://matsuand.github.io/docs.docker.jp.onthefly/compose/install/'