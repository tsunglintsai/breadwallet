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
    BRAWTransactionTypeInvalid
} BRAWTransactionType;

@interface BRAppleWatchTransactionData : NSObject<NSCoding>
@property (nonatomic, strong) NSString *amountText;
@property (nonatomic, strong) NSString *amountTextInLocalCurrency;
@property (nonatomic, strong) NSString *dateText;
@property (nonatomic) BRAWTransactionType type;
@end
