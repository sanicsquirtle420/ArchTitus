#!/bin/bash

# Installing the Base System
pacstrap /mnt base linux linux-firmware

# Generates '/etc/fstab' file
genfstab -U /mnt >> /mnt/etc/fstab

# Prepares for next step
sleep 1
cp -r /root/RacArch /mnt/root/RacArch
echo "Run 'arch-chroot /mnt' then run './1-setup.sh'."
exit
