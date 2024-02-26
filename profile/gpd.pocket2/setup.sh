#! /bin/sh

echo "Setup for GPD Pocket 2"
echo "    - copying configuration files"
tar xf gpd.pocket2_config.tar --directory=/

echo "    - firmware"
dpkg -i package/iucode-tool_2.3.1-3_amd64.deb package/intel-microcode_3.20231114.1~deb12u1_amd64.deb package/firmware-misc-nonfree_20230210-5_all.deb package/firmware-iwlwifi_20230210-5_all.deb

echo "    - wifi module"
dpkg -i package/libnl-3-200_3.7.0-0.2+b1_amd64.deb package/libnl-genl-3-200_3.7.0-0.2+b1_amd64.deb package/libnl-route-3-200_3.7.0-0.2+b1_amd64.deb package/libpcsclite1_1.9.9-2_amd64.deb package/wpasupplicant_2.10-12_amd64.deb package/wireless-regdb_2022.06.06-1_all.deb

echo "    - update system"
update-grub

echo "Basic setup completed. restart to see the changes"
echo "Notes:"
echo "   - May need to add 'non-free non-free-firmware' to apt source"
echo "   - To use bluetooth, install package blueman and pulseaudio-module-bluetooth"
echo ""
