#! /bin/sh

mkdir -p $1/etc/skel/.config/menus
cp /home/kassle/project/debian/config/xfce-applications.menu $1/etc/skel/.config/menus

mkdir -p $1/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
cp /home/kassle/project/debian/config/xfwm4.xml $1/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/kassle/project/debian/config/xfce4-notifyd.xml $1/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/kassle/project/debian/config/xfce4-panel.xml $1/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/kassle/project/debian/config/xfce4-power-manager.xml $1/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/kassle/project/debian/config/xsettings.xml $1/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/
cp /home/kassle/project/debian/config/xfce4-desktop.xml $1/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/

mkdir -p $1/etc/skel/.config/xfce4/terminal
cp /home/kassle/project/debian/config/terminalrc $1/etc/skel/.config/xfce4/terminal
