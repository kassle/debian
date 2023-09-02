#! /bin/sh

OUTFILE=$1/etc/hosts
echo "127.0.0.1 localhost" > $OUTFILE

OUTFILE=$1/etc/resolv.conf
echo "nameserver 8.8.8.8" > $OUTFILE
echo "nameserver 1.1.1.1" >> $OUTFILE

OUTFILE=$1/etc/network/interfaces
echo "source /etc/network/interfaces.d/*" > $OUTFILE

OUTFILE=$1/etc/network/interfaces.d/lo
echo "auto lo" > $OUTFILE
echo "iface lo inet loopback" >> $OUTFILE
echo "iface lo inet6 loopback" >> $OUTFILE

OUTFILE=$1/etc/network/interfaces.d/eth0
echo "auto eth0" > $OUTFILE
echo "iface eth0 inet static" >> $OUTFILE
echo "    address 192.168.0.100/24" >> $OUTFILE
echo "    gateway 192.168.0.1" >> $OUTFILE
