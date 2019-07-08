wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
chmod +x Anaconda3-2019.03-Linux-x86_64.sh
./Anaconda3-2019.03-Linux-x86_64.sh

conda install -y python=3.6

conda install -y ipython

conda install pytorch torchvision cudatoolkit=9.0 -c pytorch
conda install -y pymongo
conda install -y -c anaconda libprotobuf protobuf
conda install -y -c auto easydict
