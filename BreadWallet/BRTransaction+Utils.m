//
//  BRTransaction+Utils.m
//  BreadWallet
//
//  Created by Henry on 10/24/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

#import "BRTransaction+Utils.h"
#import "BRWalletManager.h"
#import "BRPeerManager.h"

@implementation BRTransaction (Utils)
- (BRTransactionType)transactionType {
    BRWalletManager *manager = [BRWalletManager sharedInstance];
    uint64_t received = [manager.wallet amountReceivedFromTransaction:self],
    sent = [manager.wallet amountSentByTransaction:self];
    uint32_t blockHeight = self.blockHeight;
    uint32_t confirms = ([self blockHeight] > blockHeight) ? 0 : (blockHeight - [self blockHeight]) + 1;
    if (confirms == 0 && ! [manager.wallet transactionIsValid:self]) {
        return BRTransactionTypeInvalid;
    }
    
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

- (NSString*)localCurrencyTextForAmount {
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

- (NSString*)amountText {
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

- (uint32_t)blockHeight {
    static uint32_t height = 0;
    uint32_t h = [BRPeerManager sharedInstance].lastBlockHeight;
    if (h > height) height = h;
    return height;
}

- (NSString*)dateText {
    // TODO : is there any way to move formatting from BRTxHistoryViewController to here.
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    
    NSTimeInterval t = (self.timestamp > 1) ? self.timestamp :
    [[BRPeerManager sharedInstance] timestampForBlockHeight:self.blockHeight] - 5*60;
    
    return [[[df stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:t]].lowercaseString
             stringByReplacingOccurrencesOfString:@"am" withString:@"a"]
            stringByReplacingOccurrencesOfString:@"pm" withString:@"p"];
    
    
}
@end
