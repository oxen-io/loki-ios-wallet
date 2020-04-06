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

LOKI_URL="https://github.com/loki-project/loki.git"
LOKI_DIR="$LIBRARY_DIR/loki"

SODIUM_VERSION=1.0.18-RELEASE
SODIUM_VERSION_CLEAN=1.0.18
SODIUM_HASH=940ef42797baa0278df6b7fd9e67c7590f87744b
SODIUM_URL="https://github.com/jedisct1/libsodium.git -b ${SODIUM_VERSION}"
SODIUM_DIR="$LIBRARY_DIR/libsodium"

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

echo "============================ SODIUM ============================"
if [ ! -d "$SODIUM_DIR" ]; then
  echo "Cloning libsodium from - $SODIUM_URL"
  git clone $SODIUM_URL $SODIUM_DIR
fi

pushd ${SODIUM_DIR}
test `git rev-parse HEAD` = ${SODIUM_HASH} || exit 1
./dist-build/ios.sh
popd

# NOTE: The default sodium IOS build script, builds a fat library of all the IOS
# architectures (from libsodium-ios/tmp/) into 1 (at libsodium-ios/lib). Each
# individual target has a dedicated pkgconfig file but after the manually
# merging step, there's no pkgconfig file generated for the fat library. The tmp
# directory is also deleted by default in the script, so we can't just copy it
# out and adjust the prefix folder.

# So we generate one, the contents is based off said previously generate files.
SODIUM_PREFIX=${SODIUM_DIR}/libsodium-ios
SODIUM_PKG_CONFIG=${SODIUM_PREFIX}/lib/pkgconfig
SODIUM_PKG_CONFIG_FILE=${SODIUM_PKG_CONFIG}/libsodium.pc
mkdir -p ${SODIUM_PREFIX}/lib/pkgconfig
mkdir -p ${SODIUM_PREFIX}/include

echo prefix=${SODIUM_PREFIX} >> ${SODIUM_PKG_CONFIG_FILE}
echo exec_prefix=${SODIUM_PREFIX} >> ${SODIUM_PKG_CONFIG_FILE}
echo libdir=${SODIUM_PREFIX}/lib >> ${SODIUM_PKG_CONFIG_FILE}
echo includedir=${SODIUM_PREFIX}/include >> ${SODIUM_PKG_CONFIG_FILE}
echo >> ${SODIUM_PKG_CONFIG_FILE}
echo Name: libsodium >> ${SODIUM_PKG_CONFIG_FILE}
echo Version: ${SODIUM_VERSION_CLEAN} >> ${SODIUM_PKG_CONFIG_FILE}
echo Description: A modern and easy-to-use crypto library >> ${SODIUM_PKG_CONFIG_FILE}
echo >> ${SODIUM_PKG_CONFIG_FILE}
echo Libs: -L${SODIUM_PREFIX}/lib -lsodium >> ${SODIUM_PKG_CONFIG_FILE}
echo Libs.private:  -pthread >> ${SODIUM_PKG_CONFIG_FILE}
echo Cflags: -I${SODIUM_PREFIX}/include >> ${SODIUM_PKG_CONFIG_FILE}

echo -e "\n Finished installing libraries"
