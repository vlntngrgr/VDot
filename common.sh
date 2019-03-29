#!/bin/sh
## Creating files and moving file where they should be
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
ln -svf ~/.config/dotfiles/.zshrc ~/.zshrc

echo ""
echo "----- link terminfo files -----"

tic -x ~/.config/dotfiles/terminfo/xterm-256color-italic.terminfo
tic -x ~/.config/dotfiles/terminfo/tmux-256color.terminfo


echo ""
echo "----- Install my necessary package -----"

sudo pacman -Suy
sudo pacman -S zsh git curl wget code tmux termite neovim ttf-font-awesome
sudo pacman -S xorg-server lightdm lightdm-gtk-greeter cinnamon

systemctl enable lightdm

sh ./scripts/01-omz.sh
sh ./scripts/02-tmux.sh
