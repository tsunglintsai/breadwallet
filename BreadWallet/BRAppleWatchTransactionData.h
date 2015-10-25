//
//  BRAppleWatchTransactionData.h
//  BreadWallet
//
//  Created by Henry on 10/23/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    BRAWTransactionTypeSent,
    BRAWTransactionTypeReceive,
    BRAWTransactionTypeMove,
} BRAWTransactionType;

@interface BRAppleWatchTransactionData : NSObject<NSCoding>
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *amountInLocalCurrency;
@property (nonatomic, strong) NSString *date;
@end
