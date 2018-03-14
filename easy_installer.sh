#!/usr/bin/env bash
# rocksteady, Bitcoinnova developers 2017-2018
# use this installer to clone-and-compile Bitcoinnova in one line
# supports Ubuntu 16 LTS

sudo apt-get update
yes "" | sudo apt-get install build-essential python-dev gcc-4.9 g++-4.9 git cmake libboost1.58-all-dev librocksdb-dev libboost-dev libboost-doc
export CXXFLAGS="-std=gnu++11"
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
#export DBOOST_ROOT=/home/piter/boost_1_58_0
git clone https://github.com/Bitcoin-N/Bitcoinnova-fork
cd Bitcoinnova-fork
mkdir build && cd $_
cmake  -D CMAKE_BUILD_TYPE=Release .. -DBOOST_ROOT=$HOME/boostlib
make
