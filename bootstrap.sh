#!/usr/bin/env bash

function ohmyzsh() {
	echo "Checking for oh-my-zsh"
	if [ -f /usr/bin/zsh ] && [ ! -d ~/.oh-my-zsh ];
	then
		echo "Oh-my-zsh not found.  Deploying."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
		rsync -ah --no-perms ./cobalt2/cobalt2.zsh-theme ~/.oh-my-zsh/themes/cobalt2.zsh-theme
	fi
}

function updateRepo() {
	echo "Pulling any updates from github."
	cd "$(dirname "${BASH_SOURCE}")";
	git pull --quiet origin main;
}

function dotFiles() {
	echo "Deploy .files"
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
		-ah --no-perms . ~;
	if [ ! -d ~/.config/nvim ];
	then
		mkdir -p ~/.config/nvim/
	fi
	# Copy over the nvim directories
	rsync -ah --no-perms "nvim/" ~/.config/nvim/
	# If it (~/.vimrc) doesn't exist, symlink nvim's init.vim to ~/.vimrc
	if [ ! -f ~/.vimrc ];
	then
		ln -s ~/.vimrc ~/.config/nvim/init.vim
	fi
	source ~/.bash_profile;
}

updateRepo;
ohmyzsh;
dotFiles;

unset dotFiles;
unset ohmyzsh;
unset updateRepo;

echo "All done."
