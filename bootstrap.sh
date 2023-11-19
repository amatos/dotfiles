#!/usr/bin/env bash

function ohmyzsh() {
	echo "Checking for oh-my-zsh"
	if [ ! -e /usr/bin/zsh ]; then
		echo "Please install zsh"
	elif [ ! -e ~/.oh-my-zsh ]; then
		echo "Oh-my-zsh not found.  Deploying."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
		rsync -ah --no-perms ./cobalt2/cobalt2.zsh-theme ~/.oh-my-zsh/themes/cobalt2.zsh-theme
	fi

}

function ohmyfish {
	echo "Checking for oh-my-fish"
	CWD=$(pwd)
	if [ ! -e ~/.config/fish ]; then
		ln -s "$CWD"/fish ~/.config/fish
	fi
	if [ ! -e /usr/bin/fish ]; then
		echo "Please install fish"
	elif [ ! -e ~/.local/share/omf ]; then
		echo "Oh-my-fish not found.  Deploying."
		ln -s "$CWD"/ohmyfish ~/.config/omf
		curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
	fi
}

function updateRepo() {
	echo "Pulling any updates from github."
	git pull --quiet origin main;
}

function link() {
	# symlink a file to ~ from the called directory.
	# Takes 1 required and 1 optional parameter.
	# If the 2nd parameter is not set, assume the destination name to be .$1
	# Required:
	# $1 as file to be linked to.
	# Optional
	# $2 as the symlink name.
	# e.g. if $1=foo, this will symlink ~/.foo to foo
	# e.g. if $1=foo $2=bar, this will symlink ~/bar to foo

	# Get current directory, then cd to ~
	CWD=$(pwd)
	cd ~ || exit
	# Check if .$1 exists and is not a symlink
	if [ -f ."${1}" ] && [ ! -L ."${1}" ]; then
		timestamp=$(date +%s-%N)
		echo "Found a file named .${1}.  Moving it out of the way as .${1}.${timestamp}."
		mv ."${1}" ."${1}"."${timestamp}"
	fi
	# Create the symlink
	if [ "${2}" ]; then
		ln -fs "${CWD}"/"${1}" "${2}"
	else
		ln -fs "${CWD}"/"${1}" ."${1}"
	fi
	cd ~- || exit
}

function dotFiles() {
	CWD=$(pwd)
	echo "Deploy .files"
	link aliases
	link bash_profile
	link bash_prompt
	link bashrc
	link editorconfig
	link exports
	link functions
	link gitattributes
	link gitconfig
	link gitignore
	link gvimrc
	link inputrc
	link path
	link screenrc
	link tmux.conf
	link vimrc
	link wgetrc
	link zshrc

	if [ ! -e ~/.config/nvim ];
	then
		ln -s "$CWD"/nvim ~/.config/nvim
	fi
	# If it (~/.vimrc) doesn't exist, symlink nvim's init.vim to ~/.vimrc
	if [ ! -e ~/.vimrc ];
	then
		ln -fs ~/.vimrc ~/.config/nvim/init.vim
	fi
	source "$HOME"/.bash_profile;
}

updateRepo;
ohmyzsh;
ohmyfish;
dotFiles;

unset dotFiles;
unset ohmyfish;
unset ohmyzsh;
unset updateRepo;

echo "All done."
