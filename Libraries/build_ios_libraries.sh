#!/bin/bash

SOURCE_DIR=`pwd`

BOOST_DIR_PATH="$SOURCE_DIR/boost"
OPEN_SSL_DIR_PATH="$SOURCE_DIR/openssl"
SODIUM_PATH="$SOURCE_DIR/sodium"

LOKI_CORE_URL="https://github.com/fotolockr/monero-gui.git"
LOKI_CORE_DIR_PATH="$SOURCE_DIR/loki-gui"

LOKI_URL="https://github.com/fotolockr/monero.git"
LOKI_DIR_PATH="$LOKI_CORE_DIR_PATH/loki"

ZMQ_URL="https://raw.githubusercontent.com/zeromq/cppzmq/master/zmq.hpp"
ZMQ_PATH="/usr/local/include/zmq.hpp"

USR_INCLUDES="/usr/local/include"

echo "============================ ZMQ ============================"
if [ ! -f $ZMQ_PATH ]; then
    echo "Installing ZMQ"
    curl $ZMQ_DL_PATH -o $ZMQ_PATH
else
    echo "ZMQ already installed"
fi

echo "============================ Loki-gui ============================"

echo "Cloning loki-gui from - $LOKI_CORE_URL"
git clone -b build $LOKI_CORE_URL $LOKI_CORE_DIR_PATH
cd $LOKI_CORE_DIR_PATH
git submodule init && git submodule update

echo "Cloning loki from - $LOKI_URL to - $LOKI_DIR_PATH"
git clone -b build $LOKI_URL $LOKI_DIR_PATH
cd $LOKI_DIR_PATH
git submodule init && git submodule update

cd $LOKI_CORE_DIR_PATH


echo "Export Boost vars"
export BOOST_LIBRARYDIR="$BOOST_DIR_PATH/build/ios/prefix/lib"
export BOOST_LIBRARYDIR_x86_64="$BOOST_DIR_PATH/build/libs/boost/lib/x86_64"
export BOOST_INCLUDEDIR="$BOOST_DIR_PATH/build/ios/prefix/include"

echo "Export OpenSSL vars"
export OPENSSL_INCLUDE_DIR="$OPEN_SSL_DIR_PATH/include"
export OPENSSL_ROOT_DIR="$OPEN_SSL_DIR_PATH/lib"

echo "Export Sodium vars"
export SODIUM_LIBRARY="$SODIUM_PATH/libsodium-ios/lib/libsodium.a"
export SODIUM_INCLUDE="$SODIUM_PATH/libsodium-ios/include"

# Hack to get cmake to find sodium
export CPLUS_INCLUDE_PATH=$SODIUM_INCLUDE:$USR_INCLUDES

mkdir -p monero/build
./ios_get_libwallet.api.sh

cd $SOURCE_DIR
