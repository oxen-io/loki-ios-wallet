#!/bin/bash

SOURCE_DIR=`pwd`
LIBRARY_DIR="$SOURCE_DIR/Libraries"

BOOST_URL="https://github.com/Mikunj/ofxiOSBoost.git"
BOOST_DIR_PATH="$LIBRARY_DIR/boost"

echo "Cloning ofxiOSBoost from - $BOOST_URL"
git clone -b loki $BOOST_URL $BOOST_DIR_PATH
cd $BOOST_DIR_PATH/scripts/
export BOOST_LIBS="random regex graph random chrono thread signals filesystem system date_time locale serialization program_options thread"
./build-libc++
cd $SOURCE_DIR