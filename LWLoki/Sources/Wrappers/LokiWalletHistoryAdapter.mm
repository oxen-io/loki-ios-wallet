#import <Foundation/Foundation.h>
#import "LokiWalletHistoryAdapter.h"
#import "wallet/api/wallet.h"
#import "wallet/api/transaction_history.h"
#import "LokiWalletAdapter.h"
#import "LokiTransactionInfoAdapter.mm"
#import "LokiWalletAdapter.mm"
#import "Subaddresses.mm"

@implementation LokiWalletHistoryAdapter: NSObject
Loki::TransactionHistory *transactionHistory;

- (instancetype)initWithWallet: (LokiWalletAdapter *) wallet
{
    self = [super init];
    if (self) {
        transactionHistory = [wallet rawHistory];
    }
    return self;
}

- (int)count
{
    return transactionHistory->count();
}

- (LokiTransactionInfoAdapter *)transaction:(int) index
{
    Loki::TransactionInfo *_tx = transactionHistory->transaction(index);
    LokiTransactionInfoMember *txMember = new LokiTransactionInfoMember();
    txMember->tx = _tx;
    LokiTransactionInfoAdapter *tx = [[LokiTransactionInfoAdapter alloc] initWithMember: txMember];
    return tx;
}

- (NSArray<LokiTransactionInfoAdapter *> *)getAll
{
    NSMutableArray<LokiTransactionInfoAdapter *> *_arr = [[NSMutableArray alloc] init];
    vector<Loki::TransactionInfo *> txs = transactionHistory->getAll();
    
    for (auto &originalTx : txs) {
        if (originalTx == NULL)
        {
            continue;
        }
        
        LokiTransactionInfoMember *txMember = new LokiTransactionInfoMember();
        txMember->tx = originalTx;
        LokiTransactionInfoAdapter *tx = [[LokiTransactionInfoAdapter alloc] initWithMember: txMember];
        [_arr addObject: tx];
    }
    
    return _arr;
}

- (void)refresh
{
    transactionHistory->refresh();
}
@end

