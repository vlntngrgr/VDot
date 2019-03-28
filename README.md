# VDot

## Install Arch-Linux
Those scripts are here to help me customize my Arch Linux. 
If you don't have Arch,make sure to install by following this methods:
[Install Arch Linux]!(https://wiki.archlinux.org/index.php/installation_guide)

I suggest you to partition your disk to have at least 3 partitions (4 if EFI is needed 
or in case of GPT disk):
- / (ext4 => mount /mnt)
- swap
- /home (etx4 => mount /mnt/home)
- /efi (efi partition => mount /mnt/boot/efi)

When partition are ready, connect to internet, check connection, and execute this command (it's a suggestion, 
you don't need to do the exact same install):

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
  
  $ read -r -p "Enter your username: " response
  $ export $USER=$response
  $
  $ echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
  $ locale-gen
  $
  $ echo $USER > /etc/hostname
  $ echo "127.0.0.1   localhost" >> /etc/hosts
  $ echo "::1        localhost" >> /etc/hosts
  $ echo "127.0.0.1   $USER.be  localhost" >> /etc/hosts
  $ echo "LANG=en_US.UTF-8" > /etc/locale.conf
  $
  $ passwd
  $ <root_password> 
  $ <confirm_root_password>
  $
  $ useradd <username>
  $ passwd <username>
  
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
  $ exit
  ---------------------- OUT ARCH-CHROOT -----------------------------
  $ shutdown -h now
  $
```

