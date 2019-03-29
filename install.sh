#!/bin/bash
read "enter your usename: " response
export USER=$response

echo "BASIC INSTALLATION FOR USER: $USER"

ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
hwclock --systohc
  
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen

echo $USER > /etc/hostname
echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1        localhost" >> /etc/hosts
echo "127.0.0.1   $USER.be  localhost" >> /etc/hosts
  
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LANGUAGE=en_US" >> /etc/locale.conf

echo "-- ENTER THE ROOT PASSWORD: "
passwd
  
echo "-- ENTER THE USER $USER PASSWORD: "
useradd $USER
passwd $USER
  
mkdir /home/$USER
chown -R $USER:$USER /home/$USER
echo "$USER ALL=(ALL) ALL" >> /etc/sudoers
  
pacman -S grub linux-lts linux-lts-headers openssh git networkmanager efibootmgr
  
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
  
systemctl disable dhcpcd 
systemctl disable netctl 
systemctl enable NetworkManager

