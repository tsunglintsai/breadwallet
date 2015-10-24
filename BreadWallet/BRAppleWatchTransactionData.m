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

@implementation BRAppleWatchTransactionData
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        _amount = [decoder decodeObjectForKey:AW_TRANSACTION_DATA_AMOUNT_KEY];
        _amountInLocalCurrency = [decoder decodeObjectForKey:AW_TRANSACTION_DATA_AMOUNT_IN_LOCAL_CURRENCY_KEY];
        _date = [decoder decodeObjectForKey:AW_TRANSACTION_DATA_DATE_KEY];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    if (_amount)                   [encoder encodeObject:_amount                    forKey:AW_TRANSACTION_DATA_AMOUNT_KEY];
    if (_amountInLocalCurrency)    [encoder encodeObject:_amountInLocalCurrency     forKey:AW_TRANSACTION_DATA_AMOUNT_IN_LOCAL_CURRENCY_KEY];
    if (_date)                     [encoder encodeObject:_date                      forKey:AW_TRANSACTION_DATA_DATE_KEY];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@,%@,%@",_amount,_amountInLocalCurrency,_date];
}
@end
