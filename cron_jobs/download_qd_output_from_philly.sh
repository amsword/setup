echo 'start to download the model from sc2'
date "+%H:%M:%S   %d/%m/%y"

cd /home/jianfw/code/quickdetection_stable
python scripts/qd_util.py -p \
    "{'type': 'philly_download_all_qd_output', \
      'cluster': 'sc2'}"


date "+%H:%M:%S   %d/%m/%y"
echo 'finished to download the model from sc2'
