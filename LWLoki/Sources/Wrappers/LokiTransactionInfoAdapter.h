#import "LokiWalletAdapter.h"

#ifndef LokiTransactionInfoAdapter_h
#define LokiTransactionInfoAdapter_h

struct LokiTransactionInfoMember;


@interface LokiTransactionInfoAdapter: NSObject
{
    struct LokiTransactionInfoMember *member;
}
- (int) direction;
- (BOOL) isPending;
- (BOOL) isFailed;
- (uint64_t) amount;
- (uint64_t) fee;
- (uint64_t) blockHeight;
- (uint64_t) confirmations;
- (NSString *) paymentId;
- (NSTimeInterval) timestamp;
- (NSString *) printedAmount;
- (NSString *) note;
- (NSString *) hash;
@end

#endif /* LokiTransactionInfoAdapter_h */
