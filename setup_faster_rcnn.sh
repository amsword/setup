set -e

if [ ! -d "$HOME/code/py-faster-rcnn" ]; then
    git clone --recursive git@github.com:amsword/py-faster-rcnn.git
fi

cd ~/code/py-faster-rcnn/caffe-fast-rcnn
cp Makefile.config.example Makefile.config
echo "WITH_PYTHON_LAYER := 1" >> Makefile.config
echo "USE_CUDNN := 1" >> Makefile.config
make -j
make pycaffe

cd ~/code/py-faster-rcnn

./data/scripts/fetch_faster_rcnn_models.sh

mkdir -p ~/data
cd ~/data
wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar
wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtest_06-Nov-2007.tar
wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCdevkit_08-Jun-2007.tar
tar xvf VOCtrainval_06-Nov-2007.tar
tar xvf VOCtest_06-Nov-2007.tar
tar xvf VOCdevkit_08-Jun-2007.tar

cd ~/code/py-faster-rcnn/data
ln -s ~/data/VOCdevkit VOCdevkit2007


