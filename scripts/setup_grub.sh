#! /bin/sh

OUTFILE=$1/etc/default/grub.d/ifname.cfg
echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX net.ifnames=0 biosdevname=0"' > $OUTFILE

OUTFILE=$1/etc/default/grub.d/terminal.cfg
echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX fbcon=font:TER16x32"' > $OUTFILE
