#!/bin/sh

git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'


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
ln -svf ~/.config/dotfiles/zshrc ~/.zshrc
ln -svf ~/.config/dotfiles/cinnamon ~/.cinnamon

echo ""
echo "----- link terminfo files -----"
tic -x ~/.config/dotfiles/terminfo/xterm-256color-italic.terminfo
tic -x ~/.config/dotfiles/terminfo/tmux-256color.terminfo

echo ""
echo "----- Install my necessary package -----"

sudo pacman -Suy --no-confirm
sudo pacman -S --no-confirm zsh git wget code tmux termite neovim ttf-font-awesome xorg-server lightdm lightdm-gtk-greeter cinnamom adapta-gtk-theme containerd docker docker-compose

sudo usermod -a -G docker $USER
systemctl enable lightdm


# install oh my zsh
"exit" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 

chsh -s /usr/bin/zsh

rm -rf ~/.zshrc 
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

echo ""
echo "----- configure & install tmux -----"

mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect
ln -sfv  ~/.config/dotfiles/tmux.conf ~/.tmux.conf

sh -c "$(curl -fsSL https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh)"

zsh | nvm install node | npm i -g < ./npm

fc-cache -vf

dconf load /org/cinnamon/ < cinnamon_backup

reboot
