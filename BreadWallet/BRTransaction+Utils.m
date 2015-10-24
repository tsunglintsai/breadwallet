//
//  BRTransaction+Utils.m
//  BreadWallet
//
//  Created by Henry on 10/24/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import "BRTransaction+Utils.h"
#import "BRWalletManager.h"

@implementation BRTransaction (Utils)
- (BRTransactionType)transactionType {
    BRWalletManager *manager = [BRWalletManager sharedInstance];
    uint64_t received = [manager.wallet amountReceivedFromTransaction:self],
    sent = [manager.wallet amountSentByTransaction:self];
    
    if (sent > 0 && received == sent) {
        return BRTransactionTypeMove;
    }
    else if (sent > 0) {
        return BRTransactionTypeSent;
    }
    else {
        return BRTransactionTypeReceive;
    }
}

- (NSString*)localCurrencyStringForAmount {
    BRWalletManager *manager = [BRWalletManager sharedInstance];
    uint64_t received = [manager.wallet amountReceivedFromTransaction:self],
    sent = [manager.wallet amountSentByTransaction:self];
    if (sent > 0 && received == sent) {
        return [NSString stringWithFormat:@"(%@)",
                                   [manager localCurrencyStringForAmount:sent]];
    }
    else if (sent > 0) {
        return [NSString stringWithFormat:@"(%@)",
                                   [manager localCurrencyStringForAmount:received - sent]];
    }
    else {
        return [NSString stringWithFormat:@"(%@)",
                                   [manager localCurrencyStringForAmount:received]];
    }
}

- (NSString*)amount {
    BRWalletManager *manager = [BRWalletManager sharedInstance];
    uint64_t received = [manager.wallet amountReceivedFromTransaction:self],
    sent = [manager.wallet amountSentByTransaction:self];
    if (sent > 0 && received == sent) {
        return [manager stringForAmount:sent];
    }
    else if (sent > 0) {
        return [manager stringForAmount:received - sent];
    }
    else {
        return [manager stringForAmount:received];
    }
}
@end
