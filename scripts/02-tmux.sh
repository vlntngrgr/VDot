#!/bin/sh

echo ""
echo "----- configure & install tmux -----"

if ! type "tmux" > /dev/null; then
	"y" | sudo pacman -S tmux
fi

mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect
ln -sfv "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf

if ! type "nvim" > /dev/null; then
    "y" | sudo pacman -S neovim 
fi

ln -svf "$DOTFILES_DIR/nvim" ~/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall