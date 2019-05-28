# Installation

**Before building iOS Libraries, please have a look at the [Pre-requisites](#pre-requisites)**

1. Clone the repository.
```sh
git clone https://github.com/fotolockr/CakeWallet.git
```
2. Install [Xcode 9.4.1](https://developer.apple.com/download/more/)
    - This is used for building the iOS App and the shared libraries
3. Install [homebrew](https://brew.sh/)
4. Install loki dependencies:
```sh
brew install pkgconfig
brew install cmake
brew install zeromq
```
5. Build the loki iOS libraries.
- Make sure you have `Xcode 10` or **above** for building Boost libraries.
- You can set the active xcode used for building by running: `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`
```sh
cd Libraries/
sudo xcode-select -s /Applications/Xcode10.app/Contents/Developer/
./install.sh
sudo xcode-select -s /Applications/Xcode9.app/Contents/Developer/
./build_ios.sh
cd ..
```
1. Install dependencies from Pod.
```sh
pod install
```
7. Open the `xcworkspace` in **Xcode 9** and build
# Pre-requisites

You will need additional headers for build such as: *sys/vmmeter.h, netinet/udp_var.h, netinet/ip_var.h, IOKit, [zmq.hpp](https://github.com/zeromq/cppzmq)*

zmq will be installed by the install script automatically to `/usr/local/include/zmq.hpp`

You can get them by finding them in the right framework in xcode and moving them to the required framework. This can be done by running the following:

### iPhoneSimulator.platform (Building x86)
```sh
sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/vmmeter.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/sys/

sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/udp_var.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/netinet/

sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/ip_var.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/netinet/

sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libkern/OSTypes.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/libkern

sudo cp -r /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/IOKit.framework
```

### iPhoneOS.platform (Building arm64, arm7)
```
sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/vmmeter.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/sys/

sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/udp_var.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/netinet/

sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/ip_var.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/netinet/

sudo cp /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libkern/OSTypes.h /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libkern

sudo cp -r /Applications/Xcode9.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers /Applications/Xcode9.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/IOKit.framework
```

# TEMP FIX TO BUILD LOKI SHARED LIBRARIES

Currently you will fail to build the loki shared libraries because of some errors.
Here are fixes that you should apply:

src/crypto/cn_heavy_hash.hpp:60
```diff
- #if defined(__aarch64__)
+ #if(0)
#pragma GCC target ("+crypto")
#include <sys/auxv.h>
```

CMakeLists_IOS.txt:28
```diff
set (IOS True)
+ set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D IOS")
```

CMakeLists.txt:555
```diff
  elseif(IOS AND ARCH STREQUAL "arm64")
    message(STATUS "IOS: Changing arch from arm64 to armv8")
    set(ARCH_FLAG "-march=armv8")
+ elseif(IOS AND ARCH STREQUAL "x86_64")
+   message(STATUS "IOS: Changing arch from x86_64 to x86-64")
+   set(ARCH_FLAG "-march=x86-64")
  else()
    set(ARCH_FLAG "-march=${ARCH}")
    if(ARCH STREQUAL "native")

```

src/wallet/CMakeLists.txt:77
```diff
- if (NOT LOKI_DAEMON_AND_WALLET_ONLY)
+ if (0)
```

cmake/CheckTrezor.cmake:32
```diff
# Use Trezor master switch
+ if (USE_DEVICE_TREZOR)
- if (0)
```

# Testnet

To build the application from testnet, you need to set the `TESTNET` pre-processor macro to true.
You can do this by doing the following:
1. Select your project (Make sure you are not selecting a target)
2. Go to Build Settings
3. Search "Preprocessor Macros"
4. Add `USE_TESTNET=1` to `DEBUG` or `RELEASE` depending on what your needs are.
5. Search "Swift Compiler - Custom Flags"
6. Add `USE_TESTNET` under `Active Compilation Conditions`

> We use forked the repo of [ofxiOSBoost](https://github.com/Mikunj/ofxiOSBoost/tree/loki). We do this ONLY for more convenient installation process.


