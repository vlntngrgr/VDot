# VDot
> This file needs to be rewrite, I'll do  it when this project will be over

## Install Arch-Linux
Those scripts are here to help me customize my Arch Linux. 
If you don't have Arch, make sure to install by following this methods:
[Install Arch Linux](https://wiki.archlinux.org/index.php/installation_guide)

Or you can use my way to install Arch Linux. I refer here every commands that I execute

```bash
  $ mount /dev/sdXY /mnt 
  $ mkdir /mnt/home 
  $ mount /dev/sdXZ /mnt/home
  $ [mkdir -R /mnt/boot/efi]
  $ [mount /dev/sdX1 /mnt/noot/efi]
  $ 
  $ pacstrap /mnt base [base-devel]
  $ 
  $ genfstab -U /mnt >> /mnt/etc/fstab
  $ arch-chroot /mnt
  
  ---------------------- IN ARCH-CHROOT -----------------------------
  
  $ ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
  $ hwclock --systohc
  $
  $ echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
  $ locale-gen
  $ 
  $ echo <username> > /etc/hostname
  $ echo "127.0.0.1   localhost" >> /etc/hosts
  $ echo "::1        localhost" >> /etc/hosts
  $ echo "127.0.0.1   <username>.be  localhost" >> /etc/hosts
  $
  $ echo "LANG=en_US.UTF-8" > /etc/locale.conf
  $ echo "LANGUAGE=en_US" >> /etc/locale.conf
  $ 
  $ passwd
  $
  $ useradd <username>
  $ passwd <username>
  $
  $ mkdir /home/<username>
  $ chown -R <username>:<username> /home/<username>
  $ echo "<username> ALL=(ALL) ALL" >> /etc/sudoers
  $
  $ pacman -S grub linux-lts linux-lts-headers openssh git networkmanager 
  $ [pacman -S efibootmgr]
  $
  $ grub-install /dev/sdX
  $ grub-mkconfig -o /boot/grub/grub.cfg
  $
  $ systemctl disable dhcpcd 
  $ systemctl disable netctl 
  $ systemctl enable NetworkManager
  $ 
  $ git clone https://github.com/vlntngrgr/VDot.git /home/$USER/
  $
  $ cd VDot
  $ sh common.sh
  $ exit
  ---------------------- OUT ARCH-CHROOT -----------------------------
  $ shutdown -h now
  $
```

