#import "LokiWalletAdapter.h"
#import "LokiTransactionInfoAdapter.h"

#ifndef LokiWalletHistoryAdapter_h
#define LokiWalletHistoryAdapter_h

@interface LokiWalletHistoryAdapter: NSObject
- (instancetype)initWithWallet: (LokiWalletAdapter *) wallet;
- (int)count;
- (LokiTransactionInfoAdapter *)transaction:(int) index;
- (NSArray<LokiTransactionInfoAdapter *> *)getAll;
- (void)refresh;
@end

#endif /* LokiWalletHistoryAdapter_h */
