set -e

MKL_BASE_NAME=l_mkl_2017.3.196
MKL_FILE=${MKL_BASE_NAME}.tgz
MKL_PATH_FILE=/etc/ld.so.conf.d/intel_mkl.conf

wget http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11544/${MKL_FILE}
tar -zxvf ${MKL_FILE} 
cp mkl_silent.cfg ${MKL_BASE_NAME}/
cd ${MKL_BASE_NAME}
sudo sh install.sh -s mkl_silent.cfg
cd ..
touch ${MKL_PATH_FILE}
echo "/opt/intel/lib/intel64" >> ${MKL_PATH_FILE}
echo "/opt/intel/mkl/lib/intel64" >> ${MKL_PATH_FILE}
sudo ldconfig

rm ${MKL_FILE}
rm -rf ${MKL_BASE_NAME}

