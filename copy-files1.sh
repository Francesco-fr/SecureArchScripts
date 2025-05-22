#!/usr/bin/env bash

cat ./dracut-install > /mnt/usr/local/bin/dracut-install.sh

cat ./dracut-remove > /mnt/usr/local/bin/dracut-remove.sh

chmod +x /mnt/usr/local/bin/dracut-*
mkdir /mnt/etc/pacman.d/hooks

cat ./90-dracut-install > /mnt/etc/pacman.d/hooks/90-dracut-install.hook

cat ./60-dracut-remove > /mnt/etc/pacman.d/hooks/60-dracut-remove.hook

touch /mnt/etc/dracut.conf.d/cmdline.conf
echo 'kernel_cmdline="rd.luks.uuid=luks-' > /mnt/etc/dracut.conf.d/cmdline.conf
truncate -s-1 /mnt/etc/dracut.conf.d/cmdline.conf
arch-chroot /mnt blkid -s UUID -o value /dev/nvme0n1p2 >> /mnt/etc/dracut.conf.d/cmdline.conf
truncate -s-1 /mnt/etc/dracut.conf.d/cmdline.conf
echo ' rd.lvm.lv=vg/root root=/dev/mapper/vg-root rootfstype=ext4 rootflags=rw,relatime"' >> /mnt/etc/dracut.conf.d/cmdline.conf

cat <<EOF >> /mnt/etc/dracut.conf.d/flags.conf
compress="zstd"
hostonly="no"
EOF
