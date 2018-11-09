echo 'start'
date "+%H:%M:%S   %d/%m/%y"

cd /home/jianfw/code/quickdetection_stable
python scripts/qd_util.py -p "{'type': 'philly_upload_all_data'}"

date "+%H:%M:%S   %d/%m/%y"
echo 'finished'
