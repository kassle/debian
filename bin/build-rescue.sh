SCRIPTDIR="/home/kassle/project/debian/scripts"
VERSION="bookworm"
OUTPUT="debian_rescue-$VERSION.tar"
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
    --components="main contrib non-free non-free-firmware" \
    --include=whiptail,tzdata,nano,systemd-sysv,acpi-support-base,sudo,tmux,isc-dhcp-client,inetutils-ping,inetutils-traceroute,linux-image-amd64,grub-efi,systemd-timesyncd,dbus-user-session,openssh-server,openssh-client,network-manager,wpasupplicant,wireless-regdb,firmware-linux,iucode-tool,intel-microcode,amd64-microcode,firmware-iwlwifi,e2fsprogs,mdadm,dosfstools,fdisk,ntfs-3g,curl,ca-certificates,parted \
    --customize-hook=$SCRIPTDIR/setup_apt.sh \
    --customize-hook=$SCRIPTDIR/setup_locale.sh \
    --customize-hook=$SCRIPTDIR/setup_nano.sh \
    --customize-hook=$SCRIPTDIR/setup_grub.sh \
    --customize-hook=$SCRIPTDIR/setup_tmux.sh \
    --customize-hook=$SCRIPTDIR/setup_sshd.sh \
    $VERSION $OUTPUT

gzip -9 $OUTPUT
# mv $RESULT ~/htdocs/files/
