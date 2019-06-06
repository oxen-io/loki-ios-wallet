#import <Foundation/Foundation.h>
#import "wallet/api/wallet.h"
#import "LokiAmountParser.h"

@implementation LokiAmountParser: NSObject
+ (NSString *) formatValue: (uint64_t) value
{
    return [NSString stringWithUTF8String: cryptonote::print_money(value).c_str()];
}

+ (uint64_t) amountFromString: (NSString *) str
{
    uint64_t result = 0;
    cryptonote::parse_amount(result, [str UTF8String]);
    return result;
}
@end
