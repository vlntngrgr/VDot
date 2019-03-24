#!/bin/sh

echo ""
echo "----- configure & install tmux -----"

mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect
ln -sfv  ~/.config/dotfiles/tmux.conf ~/.tmux.conf

ln -svf  ~/.config/dotfiles/nvim ~/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall