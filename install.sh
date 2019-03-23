#!/bin/sh

export DOTFILE_DIR="./.config"

if ! type "tmux" > /dev/null; then
	echo ""
	echo "----- configure & install tmux -----"
	mkdir -p ~/.config/tmux-plugins
	"y" | sudo pacman -Sy tmux
	
	mkdir -p ~/.config/tmux-plugins
	git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect
	git clone https://github.com/vlntngrgr/VDot.git ~/.plugins/.dotmux
	ln -svf ~/.plugins/.dotmux /tmux.conf
fi

echo ""
echo "----- link dotfiles -----"

ln -sfv "$DOTFILES_DIR/etc/babelrc.json" ~/.babelrc
ln -sfv "$DOTFILES_DIR/etc/curlrc" ~/.curlrc
ln -sfv "$DOTFILES_DIR/etc/editorconfig" ~/.editorconfig
ln -sfv "$DOTFILES_DIR/etc/eslintrc.js" ~/.eslintrc.js
ln -sfv "$DOTFILES_DIR/etc/gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/etc/gitignore_global" ~/.gitignore_global
ln -sfv "$DOTFILES_DIR/etc/prettierrc" ~/.prettierrc
ln -sfv "$DOTFILES_DIR/etc/wgetrc" ~/.wgetrc

echo ""
echo "----- link terminfo files -----"

tic -x "$DOTFILES_DIR/etc/terminfo/xterm-256color-italic.terminfo"
tic -x "$DOTFILES_DIR/etc/terminfo/tmux-256color.terminfo"

echo ""
echo "----- configure neovim -----"

sudo pacman -S neovim
git clone https://github.com/leny/pweneovim ~/.pweneovim
mkdir -p ~/.config
ln -sfv ~/.pweneovim ~/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
