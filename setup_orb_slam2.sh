# install Pangolin
sudo apt-get install libglew-dev
mkdir -p ~/code/
cd ~/code
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
git checkout -b for_orb_slam2 e6d000f3e21b0945baa91261dd67fc52f128b049 
mkdir build
cd build
cmake ..
cmake --build .


