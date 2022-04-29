# Installing the Base System
pacstrap /mnt base linux linux-firmware

# Generates '/etc/fstab' file
genfstab -U /mnt >> /mnt/etc/fstab

# Prepares for next step
sleep 1
echo "Please mount your ROOT partition to the /mnt directory." 
echo "Then run '1-setup.sh' to continue the process."
exit
