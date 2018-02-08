date "+%H:%M:%S   %d/%m/%y"
echo "start\n"

rsync /home/jianfw/glusterfs/public/jianfw/data/* /mnt/sda/data/ -ravz

echo "\ndone"
date "+%H:%M:%S   %d/%m/%y"
