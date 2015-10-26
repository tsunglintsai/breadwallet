//
//  BRAppleWatchTransactionData+Factory.m
//  BreadWallet
//
//  Created by Henry on 10/25/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import "BRAppleWatchTransactionData+Factory.h"
#import "BRTransaction+Utils.h"

@implementation BRAppleWatchTransactionData (Factory)
+ (instancetype)appleWatchTransactionDataFrom:(BRTransaction*)transaction {
    BRAppleWatchTransactionData *appleWatchTransactionData;
    if (transaction) {
        appleWatchTransactionData = [[BRAppleWatchTransactionData alloc] init];
        appleWatchTransactionData.amountText = transaction.amountText;
        appleWatchTransactionData.amountTextInLocalCurrency = transaction.localCurrencyTextForAmount;
        appleWatchTransactionData.dateText = transaction.dateText;
    }
    return appleWatchTransactionData;
}

+ (instancetype)appleWatchTransactionDataWithAmount:(NSString*)amount
                              amountInlocalCurrency:(NSString*)amountInlocalCurrency
                                               date:(NSString*)date {
    BRAppleWatchTransactionData *appleWatchTransactionData;
    appleWatchTransactionData = [[BRAppleWatchTransactionData alloc] init];
    appleWatchTransactionData.amountText = amount;
    appleWatchTransactionData.amountTextInLocalCurrency = amountInlocalCurrency;
    appleWatchTransactionData.dateText = date;
    return appleWatchTransactionData;
}
@end
