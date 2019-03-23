#!/bin/sh
export DOTFILES_DIR="~/.config/dotfiles"

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
cp -r ./dotfiles ~/.config

sudo rm /etc/pacman.d/mirrorlist
sudo ln -svf "$DOTFILES/mirrorlist" /etc/pacman.d/mirrorlist 

sudo pacman -Suy

if ! type "git" > /dev/null; then
	"y" | sudo pacman -S git
fi

if ! type "curl" > /dev/null; then
	"y" | sudo pacman -S curl
fi

if ! type "wget" > /dev/null; then
	"y" | sudo pacman -S wget
fi

if ! type "zsh" > /dev/null; then
	"y" | sudo pacman -Su zsh
fi

echo ""
echo "------ link dotfiles ------"

ln -sfv "$DOTFILES_DIR/babelrc.json" ~/.babelrc
ln -sfv "$DOTFILES_DIR/curlrc" ~/.curlrc
ln -sfv "$DOTFILES_DIR/editorconfig" ~/.editorconfig
ln -sfv "$DOTFILES_DIR/eslintrc.js" ~/.eslintrc.js
ln -sfv "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/gitignore_global" ~/.gitignore_global
ln -sfv "$DOTFILES_DIR/prettierrc" ~/.prettierrc
ln -sfv "$DOTFILES_DIR/wgetrc" ~/.wgetrc

echo ""
echo "----- link terminfo files -----"

tic -x "$DOTFILES_DIR/terminfo/xterm-256color-italic.terminfo"
tic -x "$DOTFILES_DIR/terminfo/tmux-256color.terminfo"

sh ./scripts/01-omz.sh
sh ./scripts/02-tmux.sh