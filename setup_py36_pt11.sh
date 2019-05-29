conda install -y python=3.6
conda install -y pytorch=1.1 torchvision cudatoolkit=9.0 -c pytorch
pip install ninja yacs cython matplotlib tqdm opencv-python
INSTALL_DIR=$PWD
mkdir -p libs
cd libs
rm -rf cocoapi
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
python setup.py build_ext install

cd $INSTALL_DIR/libs
rm apex -rf
git clone https://github.com/NVIDIA/apex.git
cd apex
python setup.py install --cuda_ext --cpp_ext



