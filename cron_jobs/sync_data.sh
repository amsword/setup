date "+%H:%M:%S   %d/%m/%y"
echo "start\n"

# sync the data 
rsync /raid/data/* /mnt/ivm_server2_od/data/ -ravz --exclude backup
echo "\ndone rsync raid to ivm"
date "+%H:%M:%S   %d/%m/%y"

#echo "begin to upload to azure blob"
#CLUSTER=eu2
#VC=input
#mySAS=?$(az keyvault secret show --vault-name philly${VC} --name ${CLUSTER} | jq .value | tr -d \" | cut -d "?" -f 2)
#TARGET_FOLDER=jianfw/data/qd_data
#BLOB_URL=https://phillyeu2storage.blob.core.windows.net/input/$TARGET_FOLDER
#azcopy --source /raid/data \
    #--destination \
        #$BLOB_URL \
    #--recursive \
    #--quiet \
    #--dest-sas $mySAS \
    #--exclude-older \
    #--parallel-level 16

#CLUSTER=sc2
#export AZURE_STORAGE_ACCESS_KEY=foobar
#/home/jianfw/code/philly/philly-fs.bash -cp -r \
    #$BLOB_URL \
    #gfs://${CLUSTER}/${VC}/$TARGET_FOLDER

date "+%H:%M:%S   %d/%m/%y"

#echo "begin to backup qd_output"
#azcopy --source /raid/jianfw/work/qd_output \
    #--destination \
        #https://phillyeu2storage.blob.core.windows.net/input/jianfw/work/qd_output \
    #--recursive \
    #--quiet \
    #--dest-sas $mySAS \
    #--exclude-older \
    #--parallel-level 16


#echo "\n rsync qd_data to eu2"
#rsync -r --no-l --progress /home/jianfw/code/quickdetection/data/ /mnt/hdfs_eu2/input/jianfw/data/qd_data/
#date "+%H:%M:%S   %d/%m/%y"

# storage usage in dlworkspace
#echo '2006wjf' | sudo -S du -sh /vighd/dlworkspace/work/* | sort -h

#echo 'build all data index'
#cd /home/jianfw/code/quickdetection && python scripts/process_tsv.py --type build_all_data_index
#echo "\ndone, build all data index"
#date "+%H:%M:%S   %d/%m/%y"


# backup data to the philly blob

#rsync /mnt/ivm_server2_od/data/* /mnt/hdfs_eu2/input/jianfw/data/qd_data/ -ravz --progress --exclude /backup

echo "\ndone"
date "+%H:%M:%S   %d/%m/%y"
