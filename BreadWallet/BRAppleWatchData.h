//
//  BRAppleWatchData.h
//  BreadWallet
//
//  Created by Henry on 10/23/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRAppleWatchTransactionData.h"
#import <UIKit/UIKit.h>

@interface BRAppleWatchData : NSObject <NSCoding>
@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) NSString *balanceInLocalCurrency;
@property (nonatomic, strong) NSString *receiveMoneyAddress;
@property (nonatomic, strong) NSString *lastestTransction;
// There is no cifilter in watchOS 2, so we have to pass image over.
@property (nonatomic, strong) UIImage *receiveMoneyQRCodeImage;
@property (nonatomic, strong) NSArray<BRAppleWatchTransactionData*> *transactions;
@property (nonatomic) BOOL hasWallet;
@end
