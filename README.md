# Installation

#### The Loki IOS Wallet is a fork of the Cake Wallet

1. Clone the repository.
```sh
git clone https://github.com/loki-project/loki-ios-wallet.git
```
2. Download a static ios build from https://builds.lokinet.dev (will be named something like
   ios-deps-[...].tar.xz), extract it into `loki-ios-wallet`, and rename (or symlink) the
   ios-deps-[...] directory to `loki-core`.
3. Install cocoapod and install pod dependences:
```sh
sudo gem install cocoapods
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
