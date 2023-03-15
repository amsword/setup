rm -rf libs/apex
mkdir -p libs
git clone https://www.github.com/nvidia/apex libs/apex
cd libs/apex
python setup.py install --cuda_ext --cpp_ext
