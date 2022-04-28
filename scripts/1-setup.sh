# Installing Packages

cat /root/RacArch/pkg-files/pacman-pkgs.txt | while read line 
do
  echo "INSTALLING: ${line}"
  sudo pacman -S --noconfirm --needed ${line}
done
