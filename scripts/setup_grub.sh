#! /bin/sh

OUTFILE=$1/etc/default/grub.d/ifname.cfg
echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX net.ifnames=0 biosdevname=0"' > $OUTFILE
