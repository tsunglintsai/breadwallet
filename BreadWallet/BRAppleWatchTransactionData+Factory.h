//
//  BRAppleWatchTransactionData+Factory.h
//  BreadWallet
//
//  Created by Henry on 10/25/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import "BRAppleWatchTransactionData.h"
#import "BRTransaction.h"

@interface BRAppleWatchTransactionData (Factory)
+ (instancetype)appleWatchTransactionDataFrom:(BRTransaction*)transaction;
+ (instancetype)appleWatchTransactionDataWithAmount:(NSString*)amount
                              amountInlocalCurrency:(NSString*)amountInlocalCurrency
                                               date:(NSString*)date;

@end
