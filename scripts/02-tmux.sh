#!/bin/sh

echo ""
echo "----- configure & install tmux -----"

if ! type "tmux" > /dev/null; then
	"y" | sudo pacman -Sy tmux
fi

mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect
ln -sfv "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf

