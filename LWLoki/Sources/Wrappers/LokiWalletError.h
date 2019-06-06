#import <Foundation/Foundation.h>

#ifndef LokiWalletError_h
#define LokiWalletError_h

FOUNDATION_EXPORT NSString *const LokiWalletErrorDomain;

enum {
    LokiWalletCreatingError = 1000,
    LokiWalletLoadingError,
    LokiWalletRecoveringError,
    LokiWalletSavingError,
    LokiWalletConnectingError,
    LokiWalletPasswordChangingError,
    LokiWalletTransactionCreatingError
};

#endif /* LokiWalletError_h */
