#! /bin/sh

OUTFILE=$1/etc/apt/sources.list
echo 'deb http://deb.debian.org/debian testing main contrib non-free non-free-firmware' > $OUTFILE
echo 'deb http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware' >> $OUTFILE
echo 'deb http://security.debian.org/debian-security testing-security main contrib non-free non-free-firmware' >> $OUTFILE
