#!/bin/sh

echo "-- -- Run this program to install basic tools and my dotfiles"
echo "-- --"

echo "-- --"
echo "-- Git config enable crendential cache..."
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

echo "--"
echo "-- Clone my dotfiles git repo..."
git clone https://github.com/vlntngrgr/dotfiles ~/.config/dotfiles

sudo rm /etc/pacman.d/mirrorlist
sudo ln -svf ~/.config/dotfiles/mirrorlist /etc/pacman.d/mirrorlist 

echo "-- "
echo "-- Link my dotfiles"
ln -sfv ~/.config/dotfiles/eslintrc.js ~/.eslintrc.js
ln -sfv ~/.config/dotfiles/prettierrc ~/.prettierrc
ln -svf ~/.config/dotfiles/zshrc ~/.zshrc
ln -svf ~/.config/dotfiles/cinnamon ~/.cinnamon
ln -sfv  ~/.config/dotfiles/tmux.conf ~/.tmux.conf

echo ""
echo "-- Install needed package"
sudo pacman -Suy
sudo pacman -S zsh git wget code tmux termite neovim chromium ttf-font-awesome adapta-gtk-theme containerd docker docker-compose libreoffice-fresh nodejs npm

#xorg-server lightdm lightdm-gtk-greeter i3 cinnamon
#echo "--"
#echo "-- Install Firefox Nightly from AUR"
#git clone https://aur.archlinux.org/firefox-nightly.git
#cd firefox-nightly
#gpg --recv-key 0x61B7B526D98F0353
#makepkg -si
#cd ..
#rm -rf firefox-nightly

#echo "--"
#echo "-- Install Postman from AUR"
#git clone https://aur.archlinux.org/postman-bin.git
#cd postman-bin
#makepkg -si 
#cd ..
#rm -rf postman-bin

#echo "--"
#echo "-- Install GitKraken from AUR"
#git clone https://aur.archlinux.org/gitkraken.git
#cd gitkraken 
#makepkg -si 
#cd ..
#rm -rf gitkraken

echo "--"
echo "-- Setting up docker to work without sudo"
sudo usermod -a -G docker $USER

echo "--"
echo "-- Enable Lightdm"
sudo systemctl enable lightdm

echo "--"
echo "-- Setting up Node / NPM to work without sudo"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
npm install -g jshint

echo "--"
echo "-- Install oh-my-zsh and configure some plugins"
exit | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 

echo "--"
echo "-- Setting up ZSH as default shell"
chsh -s /usr/bin/zsh

echo "-- "
echo "----- configure & install tmux -----"
mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect

echo "--"
echp "-- Reload all fonts"
fc-cache -vf

echo "--"
echo "-- Import my Cinnamon config"
dconf load /org/cinnamon/ < ~/.config/dotfiles/cinnamon_backup

echo "-- -- You will need to reboot your computer"
echo "-- -- Have fun!"
