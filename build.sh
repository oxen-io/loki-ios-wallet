#!/bin/bash
set -e

SOURCE_DIR=`pwd`
LIBRARY_DIR="$SOURCE_DIR/Libraries"

BOOST_DIR="$LIBRARY_DIR/boost"
LOKI_DIR="$LIBRARY_DIR/loki"
OPENSSL_DIR="$LIBRARY_DIR/openssl"

MISSING_INCLUDES_DIR="$LIBRARY_DIR/missing_headers"
mkdir -p ${MISSING_INCLUDES_DIR}/sys
mkdir -p ${MISSING_INCLUDES_DIR}/netinet

# NOTE: Libraries/loki/external/unbound/compat/getentropy_osx.c:47:10: fatal error: 'sys/vmmeter.h' file not found
# NOTE: Libraries/loki/external/unbound/compat/getentropy_osx.c:51:10: fatal error: 'netinet/ip_var.h' file not found
# TODO: This should be fixed in Unbound instead of here, it (probably) shouldn't be including a MacOSX header in an IOS build.
ln -sf /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/vmmeter.h ${MISSING_INCLUDES_DIR}/sys
ln -sf /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/netinet/ip_var.h ${MISSING_INCLUDES_DIR}/netinet
ln -sf /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/netinet/udp_var.h ${MISSING_INCLUDES_DIR}/netinet

ARCHS=(armv7 arm64 x86_64)
for ARCH_ENTRY in ${ARCHS[@]}; do
    BOOST_LIBRARY_DIR="${BOOST_DIR}/build/ios/prefix/lib"
    BUILD_TYPE=release
    IOS_PLATFORM=OS
    case ${ARCH_ENTRY} in
        "armv7")
          ;;
        "arm64")
          ;;
        "x86_64")
          BOOST_LIBRARY_DIR="${BOOST_DIR}/build/libs/boost/lib/x86_64"
          IOS_PLATFORM=SIMULATOR64
          ;;
        *)
          echo "Unhandled arch entry: ${ARCH_ENTRY}"
          exit 16
          ;;
    esac
    
    echo "============================ Building Loki Core ${ARCH_ENTRY} iOS ============================"
    # NOTE: Libraries/boost/build/ios/prefix/include/boost/asio/ssl/detail/openssl_types.hpp:19:10: fatal error: 'openssl/conf.h' file not found
    # NOTE: Libraries/loki/src/cryptonote_config.h:35:10: fatal error: 'boost/uuid/uuid.hpp' file not found
    # TODO: I think the boost one can be fixed in Loki, by including the directory in cryptonote_config's CmakeList
    export CPLUS_INCLUDE_PATH="${BOOST_DIR}/build/ios/prefix/include:${CPLUS_INCLUDE_PATH}"
    export CPLUS_INCLUDE_PATH="${OPENSSL_DIR}/include:${CPLUS_INCLUDE_PATH}"
    export CFLAGS="-I ${MISSING_INCLUDES_DIR} ${CFLAGS}"

    BUILD_DIR=${LIBRARY_DIR}/loki/build/${BUILD_TYPE}-${ARCH_ENTRY}
    mkdir -p ${BUILD_DIR}
    pushd ${BUILD_DIR}
    cmake \
            -D ARCH=${ARCH_ENTRY} \
            -D BOOST_ROOT="${BOOST_DIR}/build/ios/prefix" \
            -D BUILD_GUI_DEPS=ON \
            -D BUILD_SHARED_LIBS=OFF \
            -D CMAKE_BUILD_TYPE=${BUILD_TYPE} \
            -D CMAKE_INSTALL_PREFIX=${LOKI_DIR} \
            -D DOWNLOAD_SODIUM=FORCE \
            -D INSTALL_VENDORED_LIBUNBOUND=ON \
            -D IOS=ON \
            -D IOS_PLATFORM=${IOS_PLATFORM} \
            -D OPENSSL_ROOT_DIR=${OPENSSL_DIR} \
            -D STATIC=ON \
            ../..

    make VERBOSE=1 -j$(nproc) && make install
    popd
done

pushd ${LOKI_DIR}
mkdir -p lib-ios
lipo -create lib-armv7/libwallet_merged.a lib-x86_64/libwallet_merged.a lib-armv8-a/libwallet_merged.a -output lib-ios/libwallet_merged.a
lipo -create lib-armv7/libunbound.a lib-x86_64/libunbound.a lib-armv8-a/libunbound.a -output lib-ios/libunbound.a
lipo -create lib-armv7/libepee.a lib-x86_64/libepee.a lib-armv8-a/libepee.a -output lib-ios/libepee.a
lipo -create lib-armv7/libeasylogging.a lib-x86_64/libeasylogging.a lib-armv8-a/libeasylogging.a -output lib-ios/libeasylogging.a
popd

