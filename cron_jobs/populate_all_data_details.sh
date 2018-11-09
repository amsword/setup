echo 'start'
date "+%H:%M:%S   %d/%m/%y"

cd /home/jianfw/code/quickdetection_stable
python scripts/process_tsv.py --type build_all_data_index

date "+%H:%M:%S   %d/%m/%y"
echo 'finished'


