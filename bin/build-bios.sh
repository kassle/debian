SCRIPTDIR="/home/kassle/project/debian/scripts"
VERSION="bookworm"
OUTPUT="debian_bios-$VERSION.tar"
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
    --include=whiptail,tzdata,nano,systemd-sysv,rsyslog,logrotate,acpi-support-base,sudo,tmux,ifupdown2,isc-dhcp-client,inetutils-ping,inetutils-traceroute,linux-image-amd64,grub-pc,systemd-timesyncd,dbus-user-session,openssh-server \
    --customize-hook=$SCRIPTDIR/setup_apt.sh \
    --customize-hook=$SCRIPTDIR/setup_locale.sh \
    --customize-hook=$SCRIPTDIR/setup_nano.sh \
    --customize-hook=$SCRIPTDIR/setup_grub.sh \
    --customize-hook=$SCRIPTDIR/setup_tmux.sh \
    --customize-hook=$SCRIPTDIR/setup_sshd.sh \
    --customize-hook=$SCRIPTDIR/setup_network.sh \
    $VERSION $OUTPUT

gzip -9 $OUTPUT
# mv $RESULT ~/htdocs/files/
