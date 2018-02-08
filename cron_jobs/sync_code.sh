date "+%H:%M:%S   %d/%m/%y"
echo "start\n"
rsync /home/jianfw/code/quickdetection/* \
    REDMOND.jianfw@vig-gpu01:/home/jianfw/code/quickdetection_backup \
    -ravz

rsync /home/jianfw/code/mysite/* \
    REDMOND.jianfw@vig-gpu01:/home/jianfw/code/mysite_backup/ \
    -ravz

echo "\ndone"
date "+%H:%M:%S   %d/%m/%y"
