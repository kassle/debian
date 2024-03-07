SCRIPTDIR="/home/kassle/project/debian/scripts"
VERSION="bookworm"
OUTPUT="debian_xfce-$VERSION.tar"
RESULT="$OUTPUT.gz"

if [ -f "$OUTPUT" ]; then
    rm $OUTPUT
fi

if [ -f "$RESULT" ]; then
    rm $RESULT
fi

mmdebstrap \
    --variant=apt \
    --format=tar \
    --architectures=amd64 \
    --dpkgopt='path-exclude=/usr/share/man/*' \
    --dpkgopt='path-exclude=/usr/share/locale/*' \
    --dpkgopt='path-include=/usr/share/locale/locale.alias' \
    --dpkgopt='path-exclude=/usr/share/doc/*' \
    --dpkgopt='path-include=/usr/share/doc/*/copyright' \
    --dpkgopt='path-include=/usr/share/doc/*/changelog.Debian.*' \
    --dpkgopt='path-exclude=/usr/share/{doc,info,man,omf,help,gnome/help}/*' \
    --aptopt='Acquire::Languages "none"' \
    --include=whiptail,tzdata,nano,systemd-sysv,acpi-support-base,sudo,linux-image-amd64,grub-efi,systemd-timesyncd,dbus-user-session,network-manager-gnome,xfwm4,xfdesktop4,xfce4-session,xfce4-panel,xfce4-notifyd,thunar,desktop-base,tango-icon-theme,xfce4-terminal,xfce4-power-manager-plugins,pkexec,xfce4-pulseaudio-plugin,pulseaudio,xserver-xorg-core,xserver-xorg-input-libinput,xdg-utils,at-spi2-core,xserver-xorg-video-vesa,lightdm,lightdm-gtk-greeter,light-locker,greybird-gtk-theme,fonts-firacode,pavucontrol,thunar-volman,gvfs,gvfs-backends,eject,thermald \
    --customize-hook=$SCRIPTDIR/setup_apt.sh \
    --customize-hook=$SCRIPTDIR/setup_locale.sh \
    --customize-hook=$SCRIPTDIR/setup_nano.sh \
    --customize-hook=$SCRIPTDIR/setup_grub.sh \
    --customize-hook=$SCRIPTDIR/setup_xfce4.sh \
    --customize-hook=$SCRIPTDIR/setup_lightdm.sh \
    $VERSION $OUTPUT

gzip -9 $OUTPUT
# mv $RESULT ~/htdocs/files/
