//
//  BRTransaction+Utils.h
//  BreadWallet
//
//  Created by Henry on 10/24/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import "BRTransaction.h"

typedef enum : NSInteger {
    BRTransactionTypeSent,
    BRTransactionTypeReceive,
    BRTransactionTypeMove,
    BRTransactionTypeInvalid
} BRTransactionType;

@interface BRTransaction (Utils)
- (BRTransactionType)transactionType;
- (NSString*)amountText;
- (NSString*)localCurrencyTextForAmount;
- (NSString*)dateText;
@end
