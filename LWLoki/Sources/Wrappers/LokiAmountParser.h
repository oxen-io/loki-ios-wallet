#import <Foundation/Foundation.h>

#ifndef LokiAmountParser_h
#define LokiAmountParser_h

@interface LokiAmountParser: NSObject
@property (nonatomic) uint64_t value;
+ (NSString *) formatValue: (uint64_t) value;
+ (uint64_t) amountFromString: (NSString *) str;
@end

#endif /* LokiAmountParser_h */
