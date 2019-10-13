# Installation

**Before building iOS Libraries, please have a look at the [Pre-requisites](#pre-requisites)**

1. Clone the repository.
```sh
git clone https://github.com/fotolockr/CakeWallet.git
```
2. Install [homebrew](https://brew.sh/)
3. Install loki dependencies:
```sh
brew install pkgconfig
brew install cmake
brew install zeromq
```
4. Build the loki iOS libraries.
```sh
./install.sh
./build.sh
```
5. Install dependencies from Pod.
```sh
pod install
```

### Shared library building problems

You may get an error such as:
```
ld: symbol(s) not found for architecture armv7
```

If you get this issue then make sure that boost has been correctly built. You can check this by seeing if it exists at `Libraries/boost/builds/libs`. If the folder doesn't exist then run `./scripts/install_boost.sh` in the root director and check to see if any errors occur there.

### XCode Building problems
If you're having problems building with Xcode 10 or above then change to the `Legacy Build System`

# TEMP FIX TO BUILD LOKI SHARED LIBRARIES

Currently you will fail to build the loki shared libraries because of some errors.
Apply the changes from `loki-ios-patch.diff` to the loki folder located in `Libraries/`

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


