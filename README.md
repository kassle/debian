## Preparation
### Install required tools
sudo apt install --no-install-recommends fakechroot fakeroot mmdebstrap

## Build
### For server with bios based system x64
./bin/build-bios.sh

### For server with (u)efi based system x64
./bin/build-efi.sh

### For desktop with XFCE interface, only for (u)efi based system x64
./bin/build-xfce.sh

### compress the archive
gzip -9 debian*.tar

## Prebuilt
You can download prebuilt archive on https://files.kry.ovh/debian/

## Install

- rename the archive into debinst.tar.gz
- run debian installer, with the following parameters

```
./debinst.sh [target-dev] [username] [machine-name] [efi-boot-dev]

example:
./debinst.sh /dev/sda1 batman gotha
./debinst.sh /dev/sda2 batman gotham /dev/sda1
```

## Inside the System

### BIOS and (U)EFI x64
- based on debian stable
- dhcp client
- grub
- ifupdown2
- linux kernel
- nano
- openssh server
- ping
- timesyncd
- tmux
- traceroute

### XFCE x64
- based on debian testing
- grub
- lightdm
- linux kernel
- nano
- network manager
- pulseaudio
- xfce desktop
- xfce power manager
- xfce terminal
- xfce thunar
- timesyncd
- xorg video vesa