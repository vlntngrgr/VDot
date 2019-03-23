#!/bin/sh

# install oh my zsh
"exit" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.modules/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.modules/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.modules/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

wget https://raw.githubusercontent.com/vlntngrgr/VDot/master/.config/zshrc
mv ./.config/zshrc ~/.config/zshrc

ln -svf "$DOTFILES_DIR/zshrc" ~/.zshrc
sudo chsh -s /bin/zsh

sudo pacman -S awesome-terminal-fonts

fc-cache -vf