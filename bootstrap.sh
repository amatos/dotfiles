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
	CWD=`pwd`
	pushd ~
	ln -fs $CWD/aliases .aliases
	ln -fs $CWD/bash_profile .bash_profile
	ln -fs $CWD/bash_prompt .bash_prompt
	ln -fs $CWD/bashrc .bashrc
	ln -fs $CWD/editorconfig .editorconfig
	ln -fs $CWD/exports .exports
	ln -fs $CWD/functions .functions
	ln -fs $CWD/gitattributes .gitattributes
	ln -fs $CWD/gitconfig .gitconfig
	ln -fs $CWD/gitignore .gitignore
	ln -fs $CWD/gvimrc .gvimrc
	ln -fs $CWD/inputrc .inputrc
	ln -fs $CWD/path .path
	ln -fs $CWD/screenrc .screenrc
	ln -fs $CWD/tmux.conf .tmux.conf
	ln -fs $CWD/vim .vim
	ln -fs $CWD/vimrc .vimrc
	ln -fs $CWD/wgetrc .wgetrc
	ln -fs $CWD/zshrc .zshrc
	popd
	if [ ! -d ~/.config/nvim ];
	then
		mkdir -p ~/.config/nvim/
	fi
	# Copy over the nvim directories
	rsync -ah --no-perms "nvim/" ~/.config/nvim/
	# If it (~/.vimrc) doesn't exist, symlink nvim's init.vim to ~/.vimrc
	if [ ! -f ~/.vimrc ];
	then
		ln -fs ~/.vimrc ~/.config/nvim/init.vim
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
