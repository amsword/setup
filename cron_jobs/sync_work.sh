date "+%H:%M:%S   %d/%m/%y"
echo "start\n"

rsync /home/jianfw/glusterfs/public/jianfw/work/* /mnt/sda/work/ -ravz

echo "\ndone"
date "+%H:%M:%S   %d/%m/%y"

