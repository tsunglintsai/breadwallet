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
        appleWatchTransactionData.amount = transaction.amount;
        appleWatchTransactionData.amountInLocalCurrency = transaction.localCurrencyStringForAmount;
        appleWatchTransactionData.date = transaction.date;
    }
    return appleWatchTransactionData;
}

+ (instancetype)appleWatchTransactionDataWithAmount:(NSString*)amount
                              amountInlocalCurrency:(NSString*)amountInlocalCurrency
                                               date:(NSString*)date {
    BRAppleWatchTransactionData *appleWatchTransactionData;
    appleWatchTransactionData = [[BRAppleWatchTransactionData alloc] init];
    appleWatchTransactionData.amount = amount;
    appleWatchTransactionData.amountInLocalCurrency = amountInlocalCurrency;
    appleWatchTransactionData.date = date;
    return appleWatchTransactionData;
}
@end
