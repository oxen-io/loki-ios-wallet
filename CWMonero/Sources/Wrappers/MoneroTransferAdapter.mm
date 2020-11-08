#import <Foundation/Foundation.h>
#import "MoneroTransferAdapter.h"
#import "wallet/api/wallet2_api.h"

@implementation MoneroTransferAdapter
- (instancetype)initWithAmount:(uint64_t) amount andAddress:(NSString *) address
{
    self = [super init];
    if (self) {
        _amount = amount;
        _address = address;
    }
    return self;
}

- (instancetype)initWith:(Wallet::TransactionInfo::Transfer *)transfer
{
    self = [super init];
    if (self) {
        _amount = transfer->amount;
        _address = [NSString stringWithUTF8String: transfer->address.c_str()];
    }
    return self;
}
@end

