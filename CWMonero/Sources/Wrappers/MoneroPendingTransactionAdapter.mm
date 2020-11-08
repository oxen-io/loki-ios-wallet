#import <Foundation/Foundation.h>
#import "MoneroPendingTransactionAdapter.h"
#import "wallet/api/wallet.h"
//#import "MoneroWalletError.h"

using namespace std;

struct MoneroPendingTransactionMember {
    Wallet::PendingTransaction *tx;
    bool blink;
};

@implementation MoneroPendingTransactionAdapter

- (id)init
{
    self = [super init];
    if (self) {
        self->member = new MoneroPendingTransactionMember;
    }
    
    return self;
}

- (id)initWithMember: (MoneroPendingTransactionMember *) member
{
    self = [super init];
    if (self) {
        self->member = member;
    }
    
    return self;
}

- (void)dealloc
{
    delete member;
}

- (BOOL) commit: (NSError **) error
{
    bool isCommited = member->tx->commit("", true, member->blink);
    
    if (!isCommited) {
        if (error != NULL) {
            NSString* errorDescription = [NSString stringWithUTF8String: member->tx->status().second.c_str()];
//            *error = [NSError errorWithDomain: MoneroWalletErrorDomain
//                                         code: MoneroWalletTransactionCreatingError
//                                     userInfo: @{ NSLocalizedDescriptionKey: errorDescription }];
        }
        
        return false;
    }
    
    return true;
}

- (int) status
{
    return member->tx->status().first;
}

- (NSString *) errorString
{
    return [NSString stringWithUTF8String: member->tx->status().second.c_str()];
}

- (uint64_t) amount
{
    return member->tx->amount();
}

- (uint64_t) fee
{
    return member->tx->fee();
}

- (uint64_t) dust
{
    return member->tx->dust();
}

- (NSArray *) txid
{
    vector<string> vec = member->tx->txid();
    NSMutableArray *res = [NSMutableArray arrayWithCapacity: vec.size()];
    
    for(int i = 0; i < vec.size(); i++) {
        NSString *id = [NSString stringWithUTF8String: vec[i].c_str()];
        [res addObject: id];
    }
    
    return res;
}

- (uint64_t) txCount
{
    return member->tx->txCount();
}

@end

