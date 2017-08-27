set -e

MKL_BASE_NAME=l_mkl_2017.3.196
MKL_FILE=${MKL_BASE_NAME}.tgz

wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11544/${MKL_FILE}
tar -zxvf ${MKL_FILE} 
cp mkl_silent.cfg ${MKL_BASE_NAME}/
cd ${MKL_BASE_NAME}
sudo sh install.sh -s mkl_silent.cfg
cd ..

rm ${MKL_FILE}
rm -rf ${MKL_BASE_NAME}

