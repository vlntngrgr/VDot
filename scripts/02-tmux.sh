#!/bin/sh

echo ""
echo "----- configure & install tmux -----"

if ! type "tmux" > /dev/null; then
	"y" | sudo pacman -Sy tmux
fi

mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect
git clone https://github.com/vlntngrgr/VDot.git ~/.plugins/.dotmux
ln -svf ~/.plugins/.dotmux /tmux.conf