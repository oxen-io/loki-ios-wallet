#ifndef LokiTransferAdapter_h
#define LokiTransferAdapter_h

@interface LokiTransferAdapter : NSObject
@property (nonatomic, readonly) uint64_t amount;
@property (nonatomic, readonly) NSString *address;
- (instancetype)initWithAmount:(uint64_t) amount andAddress:(NSString *) address;
@end

#endif /* LokiTransferAdapter_h */
