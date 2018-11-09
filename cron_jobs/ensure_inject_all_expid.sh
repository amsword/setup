echo 'start'
date "+%H:%M:%S   %d/%m/%y"

cd /home/jianfw/code/quickdetection_stable
python scripts/qd_util.py -p "{'type': 'ensure_inject_all_expid'}"

date "+%H:%M:%S   %d/%m/%y"
echo 'finished'

