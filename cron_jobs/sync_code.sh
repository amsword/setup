date "+%H:%M:%S   %d/%m/%y"
echo "start\n"
rsync /home/jianfw/code/quickdetection/* \
    REDMOND.jianfw@vigdgx02:/raid/jianfw/code/quickdetection_backup \
    -ravz \
    --progress

echo "\ndone"
date "+%H:%M:%S   %d/%m/%y"
