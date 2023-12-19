#! /bin/sh

OUTFILE=$1/etc/apt/apt.conf.d/99norecommends
echo 'APT::Install-Recommends "0";' > $OUTFILE
echo 'APT::Install-Suggests "0";' >> $OUTFILE
