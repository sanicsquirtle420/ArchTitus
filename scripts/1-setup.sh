#!/bin/bash

# Installing Essential Packages
pacman -S sudo networkmanager grub efibootmgr  git vim bluez

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
echo "Now edit the sudoers file with 'vim /etc/sudoers'."
echo "Uncomment (Remove the #) the line that says '%wheel ALL=(ALL:ALL) ALL'"
echo "Save the file by typing ':wq'"
echo "After all that reboot and run '2-postinstall.sh'"
exit
