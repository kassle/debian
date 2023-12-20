#! /bin/sh

DESTDEV=$1
NEWUSER=$2
MCHNAME=$3
EFIBOOT=$4

if [ -z ${DESTDEV} ] || [ -z ${NEWUSER} ] || [ -z ${MCHNAME} ]; then
    echo "usage:"
    echo "    $0 [target-dev] [username] [machine-name] [efi-boot-dev]"
    echo ""
    echo "example:"
    echo "    $0 /dev/sda1 batman gotham"
    echo "    $0 /dev/sda2 batman gotham /dev/sda1"
    echo ""

    exit 1
fi

if [ -d "/sys/firmware/efi" ] && [ -z ${EFIBOOT} ]; then
    echo "efi env detected. but no efi boot dev"
    exit 1
fi

echo "Installing debase to $DESTDEV"
echo "    - prepare environment"
BOOTDEV=`echo $DESTDEV | sed 's/[0-9]*//g'`
DISKDEV=`basename $BOOTDEV`
DESTDIR=/mnt/debase
DEBFILE=debinst.tar.gz

export LANG="C.UTF-8"
export LANGUAGE="C.UTF-8"
export LC_ALL="C.UTF-8"

umount /mnt/debase
rm -rf /mnt/debase
mkdir -p /mnt/debase

echo "    - extract package"
mkfs.ext4 -F $DESTDEV
mount $DESTDEV $DESTDIR
tar xf $DEBFILE --directory $DESTDIR

mount --bind /dev $DESTDIR/dev
mount --bind /proc $DESTDIR/proc
mount --bind /sys $DESTDIR/sys

if [ -d "/sys/firmware/efi" ]; then
    mkdir -p $DESTDIR/boot/efi
    mount $EFIBOOT $DESTDIR/boot/efi
    mount -t efivarfs efivarfs $DESTDIR/sys/firmware/efi/efivars
fi

echo "    - configure system"
echo "127.0.1.1 $MCHNAME" >> $DESTDIR/etc/hosts
echo "$MCHNAME" > $DESTDIR/etc/hostname

chroot $DESTDIR /usr/sbin/dpkg-reconfigure tzdata

DISKUID=`blkid $DESTDEV | awk -F\" '{ print $2 }'`
# DISKFST=`blkid $DESTDEV | awk -F\" '{ print $6 }'`
DISKFST="ext4"
echo "UUID=$DISKUID /   $DISKFST    noatime,nodiratime,errors=remount-ro    0   0" > $DESTDIR/etc/fstab

if [ "$DISKDEV" = "md" ]; then
    # installing mdadm tools
    echo "Need mdadm package to install system into raid disk"
    chroot $DESTDIR /usr/bin/apt update
    chroot $DESTDIR /usr/bin/apt install --no-install-recommends --yes mdadm

    RAIDDEV=`mdadm --detail $DESTDEV | grep "active sync" | awk '{ print $7}'`
    for RD in $RAIDDEV; do
        BOOTRD=`echo $RD | sed 's/[0-9]*//g'`
        chroot $DESTDIR /usr/sbin/grub-install $BOOTRD
    done
else
    chroot $DESTDIR /usr/sbin/grub-install $BOOTDEV
fi
chroot $DESTDIR /usr/sbin/update-grub

if [ -d "/sys/firmware/efi" ]; then
    DISKUID=`blkid $EFIBOOT | awk -F\" '{ print $8 }'`
    echo "UUID=$DISKUID /boot/efi   vfat    umask=0077    0   0" >> $DESTDIR/etc/fstab

    ## virtualbox
    echo "\EFI\BOOT\grubx64.efi" > $DESTDIR/boot/efi/startup.nsh
    ## mac 
    mkdir -p $DESTDIR/boot/efi/EFI/BOOT
    cp $DESTDIR/boot/efi/EFI/debian/grubx64.efi $DESTDIR/boot/efi/EFI/BOOT/BOOTX64.EFI

    umount $DESTDIR/boot/efi
    umount $DESTDIR/sys/firmware/efi/efivars
fi

chroot $DESTDIR /usr/sbin/adduser $NEWUSER
chroot $DESTDIR /usr/sbin/adduser $NEWUSER sudo

if [ -d "/etc/network/interfaces.d" ]; then
    chroot $DESTDIR nano /etc/network/interfaces.d/eth0
fi

echo "    - clean-up"
umount $DESTDIR/dev
umount $DESTDIR/proc
umount $DESTDIR/sys
umount $DESTDIR

echo "    - completed"