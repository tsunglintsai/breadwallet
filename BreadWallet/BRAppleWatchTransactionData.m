//
//  BRAppleWatchTransactionData.m
//  BreadWallet
//
//  Created by Henry on 10/23/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import "BRAppleWatchTransactionData.h"

#define AW_TRANSACTION_DATA_AMOUNT_KEY                      @"AW_TRANSACTION_DATA_AMOUNT_KEY"
#define AW_TRANSACTION_DATA_AMOUNT_IN_LOCAL_CURRENCY_KEY    @"AW_TRANSACTION_DATA_AMOUNT_IN_LOCAL_CURRENCY_KEY"
#define AW_TRANSACTION_DATA_DATE_KEY                        @"AW_TRANSACTION_DATA_DATE_KEY"
#define AW_TRANSACTION_DATA_TYPE_KEY                        @"AW_TRANSACTION_DATA_TYPE_KEY"

@implementation BRAppleWatchTransactionData
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        _amountText = [decoder decodeObjectForKey:AW_TRANSACTION_DATA_AMOUNT_KEY];
        _amountTextInLocalCurrency = [decoder decodeObjectForKey:AW_TRANSACTION_DATA_AMOUNT_IN_LOCAL_CURRENCY_KEY];
        _dateText = [decoder decodeObjectForKey:AW_TRANSACTION_DATA_DATE_KEY];
        _type = [[decoder decodeObjectForKey:AW_TRANSACTION_DATA_TYPE_KEY] intValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    if (_amountText)                   [encoder encodeObject:_amountText                    forKey:AW_TRANSACTION_DATA_AMOUNT_KEY];
    if (_amountTextInLocalCurrency)    [encoder encodeObject:_amountTextInLocalCurrency     forKey:AW_TRANSACTION_DATA_AMOUNT_IN_LOCAL_CURRENCY_KEY];
    if (_dateText)                     [encoder encodeObject:_dateText                      forKey:AW_TRANSACTION_DATA_DATE_KEY];
    if (_type)                         [encoder encodeObject:@(_type)                       forKey:AW_TRANSACTION_DATA_TYPE_KEY];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@,%@,%@",self.amountText,self.amountTextInLocalCurrency,self.dateText];
}
@end
