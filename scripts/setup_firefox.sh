#! /bin/sh

mkdir -p $1/etc/firefox-esr
cp $DEBIAN_WORKDIR/config/firefox-zero.js $1/etc/firefox-esr
