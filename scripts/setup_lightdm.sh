#! /bin/sh

mkdir -p $1/etc/lightdm
cp $DEBIAN_WORKDIR/config/lightdm-gtk-greeter.conf $1/etc/lightdm
