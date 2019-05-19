#!/bin/sh

sudo pacman -S git wget nodejs npm php composer fish tmux containerd docker docker-compose python-pip neovim ttf-font-awesome

git config --global user.email "valentin.gregoire91@gmail.com"
git config --global user.name "vlntngrgr"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

git clone https://github.com/vlntngrgr/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
git checkout WSL
cd ~/

ln -sfv ~/.config/dotfiles/tmux.conf ~/.tmux.conf

tic -x "/home/$USER/.config/dotfiles/terminfo/xterm-256color-italic.terminfo"
tic -x "/home/$USER/.config/dotfiles/terminfo/tmux-256color.terminfo"

sudo systemctl enable docker
sudo usermod -a -G docker $USER

pip install --user --upgrade neovim
ln -sfv ~/.config/dotfiles/neovim ~/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

composer global require laravel/installer

ln -svf ~/.config/dotfiles/fish ~/.config/fish
chsh -s /usr/bin/fish | fish

mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect

fc-cache -f
