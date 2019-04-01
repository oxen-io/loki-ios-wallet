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

> We use forked repositories of [ofxiOSBoost](https://github.com/fotolockr/ofxiOSBoost), [monero](https://github.com/fotolockr/monero) and [monero-gui](https://github.com/fotolockr/monero-gui). We do this ONLY for more convenient installation process. Changes which we did in [ofxiOSBoost](https://github.com/fotolockr/ofxiOSBoost), [monero](https://github.com/fotolockr/monero) and [monero-gui](https://github.com/fotolockr/monero-gui) you can see in commit history in "build" branch of these repositories.

**Cake Technologies LLC.**
