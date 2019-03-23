#!/bin/sh
 
echo ""
echo "---------- VDot --------"
echo ""
echo "This will install & setup all the system."
read -n 1 -r -p "Ready? [y/N]" response
case $response in
    [yY]) echo "";;
    *) exit 1;;
esac
 
mkdir -p ~/.config
mkdir -p ~/.modules

sudo pacman -Suy

if ! type "git" > /dev/null; then
	"y" | sudo pacman -S git
fi

if ! type "curl" > /dev/null; then
	"y" | sudo pacman -S curl
fi

if ! type "wget" > /dev/null; then
	"y" | sudo pacman -S wget
fi

if ! type "zsh" > /dev/null; then
	"y" | sudo pacman -Su zsh
fi

sh ./scripts/01-omz.sh