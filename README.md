# Installation

#### The Loki IOS Wallet is a fork of the Cake Wallet

1. Clone the repository.
```sh
git clone https://github.com/loki-project/loki-ios-wallet.git
```
2. Install [homebrew](https://brew.sh/)
3. Install loki dependencies:
```sh
brew install pkgconfig
brew install cmake
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


