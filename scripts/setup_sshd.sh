#! /bin/sh

OUTFILE=$1/etc/ssh/sshd_config.d/listen.conf
echo "Port 22" > $OUTFILE

OUTFILE=$1/etc/ssh/sshd_config.d/auth.conf
echo "PermitRootLogin no" > $OUTFILE
echo "PasswordAuthentication yes" >> $OUTFILE
