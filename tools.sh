#!/bin/sh

echo "-- -- Run this program to install basic tools and my dotfiles"
echo "-- --"

echo "-- --"
echo "-- Git config"
git config --global user.email "valentin.gregoire91@gmail.com"
git config --global user.name "vlntngrgr"
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
ln -sfv ~/.config/dotfiles/cinnamon ~/.cinnamon
ln -sfv ~/.config/dotfiles/tmux.conf ~/.tmux.conf

echo ""
echo "----- link terminfo files -----"

tic -x "/home/$USER/.config/dotfiles/terminfo/xterm-256color-italic.terminfo"
tic -x "/home/$USER/.config/dotfiles/terminfo/tmux-256color.terminfo"

echo ""
echo "-- Install needed package"
sudo pacman -Suy
sudo pacman -S xorg-apps lightdm lightdm-webkit2-greeter cinnamon \
chromium ttf-font-awesome neovim lxterminal tmux fish wget ranger \
nodejs npm adapta-gtk-theme wireless_tools firefox containerd \
docker docker-compose libreoffice-fresh python-pip php zeal

sudo iwconfig wlp1s0 power off

echo "--"
echo "-- Setting up docker to work without sudo"
sudo usermod -a -G docker $USER

echo "--"
echo "-- Configure neovim"
pip install --user --upgrade neovim
ln -sfv ~/.config/dotfiles/neovim ~/.config/nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

echo "--"
echo "-- Install Postman from AUR"
git clone https://aur.archlinux.org/postman-bin.git
cd postman-bin
makepkg -si 
cd ..
rm -rf postman-bin

echo "--"
echo "-- Install GitKraken from AUR"
git clone https://aur.archlinux.org/gitkraken.git
cd gitkraken 
makepkg -si 
cd ..
rm -rf gitkraken

echo "--"
echo "-- Install VSCodium from AUR"
git clone https://aur.archlinux.org/vscodium.git
cd vscodium
makepkg -si
cd ..
rm -rf vscodium

echo "--"
echo "-- Install GitFlow from AUR"
git clone https://aur-dev.archlinux.org/gitflow-git.git
cd gitflow-git
makepkg -si
cd ..
rm -rf gitflow-git

echo "--"
echo "-- Enable Lightdm"
sudo systemctl enable lightdm

echo "--"
echo "-- Setting up Node / NPM to work without sudo"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

if [ -f "~/.config/terminator/config" ];then 
	rm ~/.config/terminator/config
fi
ln -svf ~/.config/dotfiles/fish ~/.config/fish
ln -svf ~/.config/dotfiles/config ~/.config/terminator/config

echo "--"
echo "-- Setting up FISH as default shell"
chsh -s /usr/bin/fish | fish

echo "-- "
echo "-- configure & install tmux"
mkdir -p ~/.config/tmux-plugins
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-plugins/tmux-resurrect

echo "--"
echo "-- Import my Cinnamon config"
dconf load /org/cinnamon/ < ~/.config/dotfiles/cinnamon_backup

# TODO: installation de mes fonts
echo "-- "
echo "-- Installing Fira Fonts"
mkdir -p ~/.fonts
cd ~/.fonts
wget https://github.com/tonsky/FiraCode/archive/1.206.tar.gz
tar -xf 1.206.tar.gz FiraCode-1.206/distr
rm 1.206.tar.gz
cd ~

echo "--"
echo "-- Reload all fonts"
fc-cache -f

echo "--"
echo "-- Install my visual studio extensions"
extcode johnpapa.winteriscoming
extcode PeterJausovec.vscode-docker
extcode emmanuelbeziat.vscode-great-icons
extcode esbenp.prettier-vscode
extcode dbaeumer.vscode-eslint
extcode onecentlin.laravel-blade
extcode onecentlin.laravel5-snippets
extcode ryannaddy.laravel-artisan
extcode felixfbecker.php-debug
extcode felixfbecker.php-intellisense
extcode gio00.fish
extcode skyapps.fish-vscode
extcode hollowtree.vue-snippets

ln -svf ~/.config/dotfiles/vscode_settings.json ~/.config/VSCodium/User/settings.json

if [ -f "~/.config/Zeal/Zeal.conf" ];then
	rm ~/.config/Zeal/Zeal.conf
fi
ln -svf ~/.config/dotfiles/Zeal.conf ~/.config/Zeal/Zeal.conf

echo "-- -- You might need to reboot your computer or just sudo systemctl start lightdm"
echo "-- -- Have fun!"
