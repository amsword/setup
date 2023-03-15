mkdir -p libs
git clone https://github.com/cocodataset/cocoapi.git libs/cocoapi
cd libs/cocoapi/PythonAPI
python setup.py build_ext install
cd ../../
