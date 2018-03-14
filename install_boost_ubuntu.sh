# install boost 1.58 ubuntu 16.04
#
#The Boost C++ Libraries were successfully built!
#
#The following directory should be added to compiler include paths:
#
#    /home/xxxxx/boost_1_64_0
#
#The following directory should be added to linker library paths:
#
#    /home/xxxxx/boost_1_64_0/stage/lib


sudo apt-get –purge remove libboost-dev
sudo apt-get –purge remove libboost-all-dev
sudo apt-get –purge autoremove libboost-all-dev
cd
wget http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
tar -xzvf boost_1_59_0.tar.gz
cd boost_1_59_0
./bootstrap.sh
./b2 --prefix=$HOME/boostlib

## verify

dpkg -s libboost-dev | grep Version