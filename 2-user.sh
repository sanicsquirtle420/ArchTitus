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
                        Script from: ArchTitus
-------------------------------------------------------------------------

Installing AUR Softwares
"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.
source $HOME/RacArch/setup.conf

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm

yay -S --noconfirm --needed - < ~/RacArch/pkg-files/aur-pkgs.txt

export PATH=$PATH:~/.local/bin
cd ~/RacArch
git clone "https://github.com/sanicsquirtle420/dotfiles"
cp -r ~/RacArch/dotfiles/* ~/.config/

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
