#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude "nvim/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE.md" \
		--exclude "cobalt2" \
		--exclude "init" \
		--exclude "brew.sh" \
		-avh --no-perms . ~;
	rsync -avh --no-perms "nvim/" ~/.config/nvim/ ~;
	ln -s ~/.vimrc ~/.config/nvim/init.vim
	source ~/.bash_profile;
}

doIt;
unset doIt;

if [ -f /usr/bin/zsh ];
then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	rsync -avh --no-perms ./cobalt2/cobalt2.zsh-theme ~/.oh-my-zsh/themes/cobalt2.zsh-theme
fi
