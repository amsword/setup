pip install --upgrade pip
conda install -y ipython
pip install ninja yacs cython matplotlib
conda install pytorch-nightly -c pytorch
cd ..

git clone https://github.com/pytorch/vision.git
cd vision
python setup.py install
cd ..

git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
python setup.py build_ext install
cd ../../

git clone https://github.com/facebookresearch/maskrcnn-benchmark.git
cd maskrcnn-benchmark
python setup.py build develop
