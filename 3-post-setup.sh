#!/usr/bin/env bash
echo -ne "
-------------------------------------------------------------------------
                              .                : :
            _..----..__   __..:'.-'''-.-''    .  :
          .'      ,    '''    '    :   .'    /  '
         ',                  ( -=o):(o=-)   .  :
        :     ,               ''.  ;  .'  __:  :
        :          :      ,      '.0.''.-'.))  :  __..--
        :           :                ._.-'__| ':''.
         .           :   ,   ..  :.-' __.' /   ;    . 
        .'       ,   :    _.'  '. '.''    /   /  '
      .:. .'.        :--:'_..--'''.))  .  ' -'    __.--'
    .''::'   '-.  .-''.  '.   .             __.--'
    :...:     __\  '.  '..))     '    __.--'
    ::'':.--''   '.)))          __.--'
_..--:.::'   .         .  __.--'
      :' .:.        __.--'
  '    .::' : __.--'
jrei  __' .::'
..--''   ':::' 
                                RacArch
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
                        SCRIPTHOME: ArchTitus
-------------------------------------------------------------------------

Final Setup and Configurations
GRUB EFI Bootloader Install & Check
"
source /root/RacArch/setup.conf
genfstab -U / >> /etc/fstab
if [[ -d "/sys/firmware/efi" ]]; then
    grub-install --efi-directory=/boot ${DISK}
fi
# set kernel parameter for decrypting the drive
if [[ "${FS}" == "luks" ]]; then
sed -i "s%GRUB_CMDLINE_LINUX_DEFAULT=\"%GRUB_CMDLINE_LINUX_DEFAULT=\"cryptdevice=UUID=${encryped_partition_uuid}:ROOT root=/dev/mapper/ROOT %g" /etc/default/grub
fi

echo -e "Backing up Grub config..."
cp -an /etc/default/grub /etc/default/grub.bak

grub-mkconfig -o /boot/grub/grub.cfg
echo -e "All set!"

echo -ne "
-------------------------------------------------------------------------
                    Enabling Login Display Manager
-------------------------------------------------------------------------
"
systemctl enable sddm.service
echo -ne "
-------------------------------------------------------------------------
                    Enabling Essential Services
-------------------------------------------------------------------------
"
systemctl enable cups.service
ntpd -qg
systemctl enable ntpd.service
systemctl disable dhcpcd.service
systemctl stop dhcpcd.service
systemctl enable NetworkManager.service
systemctl enable bluetooth
echo -ne "
-------------------------------------------------------------------------
                    Cleaning 
-------------------------------------------------------------------------
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

rm -r /root/RacArch
rm -r /home/$USERNAME/RacArch

# Replace in the same state
cd $pwd
