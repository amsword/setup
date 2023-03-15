sudo apt-get install openvpn easy-rsa

make-cadir ~/openvpn-ca
cd ~/openvpn-ca
cp openssl-1.0.0.cnf openssl.cnf
# change key_name as server
source vars
./build-ca

./build-key-server server

./build-dh
openvpn --genkey --secret keys/ta.key




