# Rac Arch

<img src="..." />

This README contains the steps I do to install and configure a fully-functional Arch Linux installation containing a tiling window manager, all the support packages (network, bluetooth, audio, printers, etc.), along with all my preferred applications and utilities. The shell scripts in this repo allow the entire process to be automated.)

---
## Create Arch ISO or Use Image

Download ArchISO from <https://archlinux.org/download/> and put on a USB drive with [Etcher](https://www.balena.io/etcher/), [Ventoy](https://www.ventoy.net/en/index.html), or [Rufus](https://rufus.ie/en/)

## Initial Setup

### Partitioning Disks
Run `fdisk /dev/sdX` to begin the partion process. Follow the [Arch Linux Partition Guide](https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks) to partion your drives correctly. NOTE: /dev/sdX the X is a variable for what letter could be there (/dev/sda, /dev/sdb, etc.) `fdisk -l` will list all drives.

### Formating Partitions
- SWAP Partition `mkswap /dev/swap_part`
- EFI Partition `mkfs.fat -F 32 /dev/efi_part` (if applicable)
- ROOT Partition `mkfs.ext4 /dev/root_part`

### Mounting Partitions
- SWAP Partition `swapon /dev/swap_part`
- EFI Partition `mount --mkdir /dev/efi_part /mnt/efi` (if applicable)
- ROOT Partition `mount /dev/root_part /mnt`

### System Description
This is completely automated Arch Linux install with i3 and basic applications, mostly GNOME applications.

### From initial Prompt type the following commands:
```
pacman -Sy git
git clone https://github.com/sanicsquirtle420/RacArch
cd ~/RacArch
./0-preinstall.sh
```
 
## Troubleshooting

__[Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)__

### No Wifi

You can check if the WiFi is blocked by running `rfkill list`.
If it says **Soft blocked: yes**, then run `rfkill unblock wifi`

After unblocking the WiFi, you can connect to it. Go through these 5 steps:

#1: Run `iwctl`

#2: Run `device list`, and find your device name.

#3: Run `station [device name] scan`

#4: Run `station [device name] get-networks`

#5: Find your network, and run `station [device name] connect [network name]`, enter your password and run `exit`. You can test if you have internet connection by running `ping google.com`, and then Press Ctrl and C to stop the ping test.

## Credits

- Original packages script was a post install cleanup script called ArchMatic located here: https://github.com/rickellis/ArchMatic
