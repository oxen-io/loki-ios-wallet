# Installation

**Before building iOS Libraries, please have a look at the [Pre-requisites](#pre-requisites)**

1. Clone the repository.
```sh
git clone https://github.com/fotolockr/CakeWallet.git
```
2. Install [Xcode 9.4.1](https://developer.apple.com/download/more/)
3. Install [homebrew](https://brew.sh/)
4. Install loki dependencies:
```sh
brew install pkgconfig
brew install cmake
brew install zeromq
```
5. Build the loki iOS libraries
```sh
cd Libraries/
./install.sh
./build_ios.sh
cd ..
```
6. Install dependencies from Pod.
```sh
pod install
```

# Pre-requisites

You will need additional headers for build such as: *sys/vmmeter.h, netinet/udp_var.h, netinet/ip_var.h, IOKit, [zmq.hpp](https://github.com/zeromq/cppzmq)*

zmq will be installed by the install script automatically to `/usr/local/include/zmq.hpp`

You can get them by finding them in the right framework in xcode and moving them to the required framework. This can be done by running the following:

### iPhoneSimulator.platform (Building x86)
```sh
sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/vmmeter.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/sys/

sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/udp_var.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/netinet/

sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/ip_var.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/netinet/

sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libkern/OSTypes.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include/libkern

sudo cp -r /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/IOKit.framework
```

### iPhoneOS.platform (Building arm64, arm7)
```
sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/vmmeter.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/sys/

sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/udp_var.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/netinet/

sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/ip_var.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/netinet/

sudo cp /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libkern/OSTypes.h /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/libkern

sudo cp -r /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/IOKit.framework
```

# TEMP FIX TO BUILD LOKI SHARED LIBRARIES

Currently you will fail to build the loki shared libraries because of some errors.
Here are fixes that you should apply:

src/crypto/cn_heavy_hash.hpp:60
```diff
- #if defined(__aarch64__)
+ #if defined(__aarch64__) && !defined(IOS)
```

CMakeLists_IOS.txt:28
```diff
set (IOS True)
+ set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D IOS")
```

CMakeLists.txt:548
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


> We use forked the repo of [ofxiOSBoost](https://github.com/Mikunj/ofxiOSBoost/tree/loki). We do this ONLY for more convenient installation process.


