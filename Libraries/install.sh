#!/bin/bash

SOURCE_DIR=`pwd`

ZMQ_URL="https://raw.githubusercontent.com/zeromq/cppzmq/master/zmq.hpp"
ZMQ_PATH="/usr/local/include/zmq.hpp"

BOOST_URL="https://github.com/fotolockr/ofxiOSBoost.git"
BOOST_DIR_PATH="$SOURCE_DIR/boost"

OPEN_SSL_URL="https://github.com/x2on/OpenSSL-for-iPhone.git"
OPEN_SSL_DIR_PATH="$SOURCE_DIR/openssl"

SODIUM_URL="https://github.com/jedisct1/libsodium --branch stable"
SODIUM_PATH="$SOURCE_DIR/sodium"

LMDB_DIR_URL="https://github.com/LMDB/lmdb.git"
LMDB_DIR_PATH="$SOURCE_DIR/../lmdb/Sources"

LOKI_URL="https://github.com/fotolockr/monero.git"
LOKI_DIR_PATH="$SOURCE_DIR/loki"

echo "============================ ZMQ ============================"
if [ ! -f $ZMQ_PATH ]; then
    echo "Installing ZMQ"
    curl $ZMQ_DL_PATH -o $ZMQ_PATH
else
    echo "ZMQ already installed"
fi

echo "============================ Boost ============================"

echo "Cloning ofxiOSBoost from - $BOOST_URL"
git clone -b build $BOOST_URL $BOOST_DIR_PATH
cd $BOOST_DIR_PATH/scripts/
export BOOST_LIBS="random regex graph random chrono thread signals filesystem system date_time locale serialization program_options"
./build-libc++
cd $SOURCE_DIR

echo "============================ OpenSSL ============================"

echo "Cloning Open SSL from - $OPEN_SSL_URL"
git clone $OPEN_SSL_URL $OPEN_SSL_DIR_PATH
cd $OPEN_SSL_DIR_PATH
./build-libssl.sh --version=1.0.2j
cd $SOURCE_DIR

echo "============================ LMDB ============================"
echo "Cloning lmdb from - $LMDB_DIR_URL"
git clone $LMDB_DIR_URL $LMDB_DIR_PATH
cd $LMDB_DIR_PATH
git checkout b9495245b4b96ad6698849e1c1c816c346f27c3c
cd $SOURCE_DIR

echo "============================ SODIUM ============================"
echo "Cloning SODIUM from - $SODIUM_URL"
git clone -b build $SODIUM_URL $SODIUM_PATH
cd $SODIUM_PATH
./dist-build/ios.sh
cd $SOURCE_DIR

echo "============================ LOKI ============================"

echo "Cloning loki from - $LOKI_URL to - $LOKI_DIR_PATH"
git clone -b build $LOKI_URL $LOKI_DIR_PATH
cd $LOKI_DIR_PATH
git submodule init && git submodule update
cd $SOURCE_DIR

echo "\n Finished installing libraries"