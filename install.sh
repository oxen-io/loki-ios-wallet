#!/bin/bash

set -e
mkdir -p Libraries

SOURCE_DIR=`pwd`
LIBRARY_DIR="$SOURCE_DIR/Libraries"

BOOST_URL="https://github.com/Mikunj/ofxiOSBoost.git"
BOOST_DIR="$LIBRARY_DIR/boost"

OPENSSL_URL="https://github.com/x2on/OpenSSL-for-iPhone.git"
OPENSSL_DIR="$LIBRARY_DIR/openssl"

LMDB_URL="https://github.com/LMDB/lmdb.git"
LMDB_DIR="$LIBRARY_DIR/../lmdb/Sources"

LOKI_URL="https://github.com/loki-project/loki.git"
LOKI_DIR="$LIBRARY_DIR/loki"

echo "============================ OpenSSL ============================"
if [ ! -d "$OPENSSL_DIR" ]; then
  echo "Cloning Open SSL from - $OPENSSL_URL"
  git clone $OPENSSL_URL $OPENSSL_DIR
fi

pushd $OPENSSL_DIR
./build-libssl.sh --archs="x86_64 arm64 armv7s armv7" --targets="ios-sim-cross-x86_64 ios64-cross-arm64 ios-cross-armv7s ios-cross-armv7"
popd

echo "============================ LMDB ============================"
if [ ! -d "$LMDB_DIR" ]; then
  echo "Cloning lmdb from - $LMDB_URL"
  git clone $LMDB_URL $LMDB_DIR
fi

pushd $LMDB_DIR
git checkout b9495245b4b96ad6698849e1c1c816c346f27c3c
popd

echo "============================ LOKI ============================"
if [ ! -d "$LOKI_DIR" ]; then
  echo "Cloning loki from - $LOKI_URL to - $LOKI_DIR"
  git clone --recursive $LOKI_URL $LOKI_DIR
fi

echo "============================ BOOST ============================"
if [ ! -d "$BOOST_DIR" ]; then
  echo "Cloning ofxiOSBoost from - $BOOST_URL"
  git clone -b loki $BOOST_URL $BOOST_DIR
fi

pushd $BOOST_DIR/scripts/
export BOOST_LIBS="atomic chrono date_time filesystem program_options regex serialization system thread"
./build-libc++
popd $SOURCE_DIR

echo -e "\n Finished installing libraries"
