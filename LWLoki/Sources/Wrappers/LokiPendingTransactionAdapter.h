#import <Foundation/Foundation.h>

#ifndef LokiPendingTransactionAdapter_h
#define LokiPendingTransactionAdapter_h

struct LokiPendingTransactionMember;


@interface LokiPendingTransactionAdapter: NSObject
{
    struct LokiPendingTransactionMember* member;
};

//- (id) initWithMember: (LokiPendingTransactionMember *) member;
- (int) status;
- (NSString *) errorString;
- (uint64_t) amount;
- (uint64_t) fee;
- (uint64_t) dust;
- (NSArray *) txid;
- (uint64_t) txCount;
- (BOOL) commit: (NSError **) error;
//- (NSString *) hash;
@end

#endif /* LokiPendingTransactionAdapter_h */
