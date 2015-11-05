CUDNN_URL='http://developer.download.nvidia.com/assets/cuda/secure/cuDNN/v3/cudnn-7.0-linux-x64-v3.0-prod.tgz?autho=1446718056_a1fae089424dd8480fc43554ddea316f&file=cudnn-7.0-linux-x64-v3.0-prod.tgz'
DOWNLOADED='cudnn.tgz'
wget $CUDNN_URL -O $DOWNLOADED 
tar -xvzf $DOWNLOADED 
