#!/bin/bash
echo "-- -- Install ArchLinux Base in arch-chroot"
echo "-- Belgium, Brussels, Qwerty US, EFI, en_US Language"

echo "--"
echo "-- Enter your username"
read response
export USER=$response

echo "--"
echo "-- Basic Arch linux installation"

echo "--"
echo "-- Setting Brussels timezone"
ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
hwclock --systohc
  
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen

echo "$USER-surface" > /etc/hostname
echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1        localhost" >> /etc/hosts
echo "127.0.0.1   $USER.be  localhost" >> /etc/hosts
  
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LANGUAGE=en_US" >> /etc/locale.conf

echo "--"
echo "-- Enter root password"
passwd

echo "--"
echo "-- Enter $USER password:  "
useradd $USER
passwd $USER
  
mkdir /home/$USER
chown -R $USER:$USER /home/$USER
echo "$USER ALL=(ALL) ALL" >> /etc/sudoers
  
pacman -S grub openssh git networkmanager efibootmgr
  
#grub-install /dev/sda
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

echo "--"
echo "-- -- User = $USER"
echo "-- -- Hostname = $USER-desktop"
echo "-- -- hosts = $USER.be"
echo "-- --"
echo "-- You can exit arch-chroot and reboot!"
echo "-- Have fun with Arch Linux"
