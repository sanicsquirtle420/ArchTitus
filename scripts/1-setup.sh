#!/bin/bash

# Installing Essential Packages
pacman -S sudo networkmanager grub efibootmgr  git vim

# Enableing / Configuring Essential Packages
systemctl enable NetworkManager.service
mkdir /boot/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Finishing Steps
echo "Congrats the basic Arch Linux system has been installed."
sleep 1
read -p "Type your username (All lowercase please)... " username
useradd -m $username
usermod -aG wheel ${username}
echo "User ${username} has been created and has been given sudo privileges"
sleep 1
echo "Now let's set the password for '${username} ..."
passwd $username

echo "Perfect!"
echo "Now reboot the system with 'reboot' then run '2-postinstall.sh'."
exit
