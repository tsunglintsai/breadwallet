//
//  BRAppleWatchData.m
//  BreadWallet
//
//  Created by Henry on 10/23/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import "BRAppleWatchData.h"

#define AW_DATA_BALANCE_KEY                     @"AW_DATA_BALANCE_KEY"
#define AW_DATA_BALANCE_LOCAL_KEY               @"AW_DATA_BALANCE_LOCAL_KEY"
#define AW_DATA_RECEIVE_MONEY_ADDRESS           @"AW_DATA_RECEIVE_MONEY_ADDRESS"
#define AW_DATA_RECEIVE_MONEY_QR_CODE           @"AW_DATA_RECEIVE_MONEY_QR_CODE"
#define AW_DATA_TRANSACTIONS                    @"AW_DATA_TRANSACTIONS"

@implementation BRAppleWatchData
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        _balance = [decoder decodeObjectForKey:AW_DATA_BALANCE_KEY];
        _balanceInLocalCurrency = [decoder decodeObjectForKey:AW_DATA_BALANCE_LOCAL_KEY];
        _receiveMoneyAddress = [decoder decodeObjectForKey:AW_DATA_RECEIVE_MONEY_ADDRESS];
        _receiveMoneyQRCodeImage = [decoder decodeObjectForKey:AW_DATA_RECEIVE_MONEY_QR_CODE];
        _transactions = [decoder decodeObjectForKey:AW_DATA_TRANSACTIONS];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    if (_balance)                   [encoder encodeObject:_balance                      forKey:AW_DATA_BALANCE_KEY];
    if (_balanceInLocalCurrency)    [encoder encodeObject:_balanceInLocalCurrency       forKey:AW_DATA_BALANCE_LOCAL_KEY];
    if (_receiveMoneyAddress)       [encoder encodeObject:_receiveMoneyAddress          forKey:AW_DATA_RECEIVE_MONEY_ADDRESS];
    if (_receiveMoneyQRCodeImage)   [encoder encodeObject:_receiveMoneyQRCodeImage      forKey:AW_DATA_RECEIVE_MONEY_QR_CODE];
    if (_transactions)              [encoder encodeObject:_transactions                 forKey:AW_DATA_TRANSACTIONS];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%@,%@,%@,%@,image size:%@",_balance,_balanceInLocalCurrency,_receiveMoneyAddress,_transactions,@(_receiveMoneyQRCodeImage.size.height)];
}
@end
