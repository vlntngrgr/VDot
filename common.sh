#!/bin/sh

echo ""
echo "---------- VDot --------"
echo ""
echo "This will install & setup all the system."
read -n 1 -r -p "Ready? [y/N]" response
case $response in
    [yY]) echo "";;
    *) exit 1;;
esac

## Creating files and moving file where they should be
mkdir -p ~/.modules
mkdir -p ~/.config/dotfiles
cp -r dotfiles ~/.config/

sudo rm /etc/pacman.d/mirrorlist
sudo ln -svf ~/.config/dotfiles/mirrorlist /etc/pacman.d/mirrorlist 

echo ""
echo "------ link dotfiles ------"

ln -sfv ~/.config/dotfiles/babelrc.json ~/.babelrc
ln -sfv ~/.config/dotfiles/curlrc ~/.curlrc
ln -sfv ~/.config/dotfiles/editorconfig ~/.editorconfig
ln -sfv ~/.config/dotfiles/eslintrc.js ~/.eslintrc.js
ln -sfv ~/.config/dotfiles/gitconfig ~/.gitconfig
ln -sfv ~/.config/dotfiles/gitignore_global ~/.gitignore_global
ln -sfv ~/.config/dotfiles/prettierrc ~/.prettierrc
ln -sfv ~/.config/dotfiles/wgetrc ~/.wgetrc

echo ""
echo "----- link terminfo files -----"

tic -x ~/.config/dotfiles/terminfo/xterm-256color-italic.terminfo
tic -x ~/.config/dotfiles/terminfo/tmux-256color.terminfo

"y" | sudo pacman -Suy git curl wget zsh code awesome-terminal-fonts tmux termit neovim vim

sh ./scripts/01-omz.sh
sh ./scripts/02-tmux.sh
sh ./scripts/workspace.sh
