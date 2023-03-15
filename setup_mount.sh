sshpass -p accessPnrsy sshfs -p 84 userpnrsy@phillyonap:/var/nfs-mount/input /mnt/proxy/proxypap
LOCAL_UID=`id -u jianfw`
sudo mount -t cifs //ivm-server2/IRIS/OD /mnt/ivm_server2_od -o user=jianfw,pass=GoodAfternoon88_,domain=REDMOND,uid=$LOCAL_UID,vers=2.0

