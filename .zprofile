# Start display server
[ "$(tty)" = /dev/tty1 ] && ssh-agent startx

# Backup fstab
cp /etc/fstab ~/fstab-backup
