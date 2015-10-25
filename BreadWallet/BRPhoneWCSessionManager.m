//
//  BRAppGroupConstants.h
//  BreadWallet
//
//  Created by Henry Tsai on 10/22/15.
//  Copyright (c) 2013 Aaron Voisine <voisine@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BRPhoneWCSessionManager.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "BRAppleWatchSharedConstants.h"
#import "BRWalletManager.h"
#import "BRPaymentRequest.h"
#import "UIImage+Utils.h"
#import "BRAppleWatchTransactionData+Factory.h"

@interface BRPhoneWCSessionManager()<WCSessionDelegate>
@end

@implementation BRPhoneWCSessionManager

+ (instancetype)sharedInstance {
    static BRPhoneWCSessionManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if ( self = [super init]){
        [WCSession defaultSession].delegate = self;
        [[WCSession defaultSession] activateSession];
    }
    return self;
}

#pragma mark - WKSession delegate
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    switch ([message[AW_SESSION_REQUEST_DATA_TYPE_KEY] integerValue]) {
        case AWSessionRquestDataTypeAllData:
            [self handleAllDataRequest:message replyHandler:replyHandler];
            break;
        case AWSessionRquestDataTypeGlanceData:
            [self handleGlanceDataRequest:message replyHandler:replyHandler];
            break;
        case AWSessionRquestDataTypeBalance:
            [self handleBalanceDataRequest:message replyHandler:replyHandler];
            break;
        case AWSessionRquestDataTypeTransactions:
            [self handleTransactionsDataRequest:message replyHandler:replyHandler];
            break;
        case AWSessionRquestDataTypeReceiveMoneyQR:
            [self handleReceiveMoneyQRRequest:message replyHandler:replyHandler];
            break;
        default:
            replyHandler(@{});
    }
}

#pragma mark - request handlers

- (void)handleAllDataRequest:(NSDictionary*)request replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    BRWalletManager *manager = [BRWalletManager sharedInstance];
    NSArray *transactions = manager.wallet.recentTransactions;
    
    NSMutableArray *transactionData = [[NSMutableArray alloc] init];
    [transactionData addObject:[BRAppleWatchTransactionData appleWatchTransactionDataWithAmount:@"100" amountInlocalCurrency:@"101" date:@"10/10/2015"]];
    [transactionData addObject:[BRAppleWatchTransactionData appleWatchTransactionDataWithAmount:@"200" amountInlocalCurrency:@"201" date:@"10/11/2015"]];
    [transactionData addObject:[BRAppleWatchTransactionData appleWatchTransactionDataWithAmount:@"300" amountInlocalCurrency:@"301" date:@"10/12/2015"]];
    
    UIImage *qrCodeImage = self.qrCode;
    
    BRAppleWatchData *appleWatchData = [[BRAppleWatchData alloc] init];
    appleWatchData.balance = [manager stringForAmount:manager.wallet.balance];
    appleWatchData.balanceInLocalCurrency = [manager localCurrencyStringForAmount:manager.wallet.balance];
    appleWatchData.receiveMoneyAddress = [BRWalletManager sharedInstance].wallet.receiveAddress;
    appleWatchData.transactions = [transactionData copy];
    appleWatchData.receiveMoneyQRCodeImage = qrCodeImage;
    appleWatchData.hasWallet = !manager.noWallet;
    
    NSDictionary *replay = @{AW_SESSION_REQUEST_KEY: request, AW_SESSION_RESPONSE_KEY: [NSKeyedArchiver archivedDataWithRootObject:appleWatchData]};
    
    replyHandler(replay);
}

- (void)handleGlanceDataRequest:(NSDictionary*)request replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    BRWalletManager *manager = [BRWalletManager sharedInstance];
    BRAppleWatchData *appleWatchData = [[BRAppleWatchData alloc] init];
    appleWatchData.balance = [manager stringForAmount:manager.wallet.balance];
    appleWatchData.balanceInLocalCurrency = [manager localCurrencyStringForAmount:manager.wallet.balance];
    appleWatchData.lastestTransction = @"receive ƀ102,000 ($10.00) 5 days ago";
    appleWatchData.hasWallet = !manager.noWallet;
    NSDictionary *replay = @{AW_SESSION_REQUEST_KEY: request, AW_SESSION_RESPONSE_KEY: [NSKeyedArchiver archivedDataWithRootObject:appleWatchData]};
    replyHandler(replay);
}

- (void)handleBalanceDataRequest:(NSDictionary*)request replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    NSDictionary *replay = @{AW_SESSION_REQUEST_KEY: request,@"Balance":@"Balance"};
    replyHandler(replay);
}

- (void)handleTransactionsDataRequest:(NSDictionary*)request replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    NSDictionary *replay = @{AW_SESSION_REQUEST_KEY: request,@"Transaction":@"Transaction"};
    replyHandler(replay);
}


- (void)handleReceiveMoneyQRRequest:(NSDictionary*)request replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    NSDictionary *replay = @{AW_SESSION_REQUEST_KEY: request,@"ReceiveMoneyQR":@"ReceiveMoneyQR"};
    replyHandler(replay);
}

- (UIImage*)qrCode {
    BRWalletManager *manager = [BRWalletManager sharedInstance];
    return [UIImage imageWithQRCodeData:[BRPaymentRequest requestWithString:manager.wallet.receiveAddress].data size:CGSizeMake(150, 150)
                           color:[CIColor colorWithRed:0.0 green:0.0 blue:0.0]];
}

#pragma mark - data helper methods

- (NSArray*)recentTransactionList {
//    BRWalletManager *manager = [BRWalletManager sharedInstance];
//    NSArray *transactions = manager.wallet.recentTransactions;
//    NSMutableArray *transactionData = [[NSMutableArray alloc] init];
//    for ( BRTransaction *tx in transactions) {
//        uint64_t received = [manager.wallet amountReceivedFromTransaction:tx],
//        sent = [manager.wallet amountSentByTransaction:tx];
//    }
    
//    BRAppleWatchTransactionData *appleWatchTransactionData = [[BRAppleWatchTransactionData alloc] init];
//    appleWatchTransactionData.amount = @100;
//    appleWatchTransactionData.amountInLocalCurrency = @"amountInLocalCurrency";
//    appleWatchTransactionData.date = [NSDate date];
//    [transactionData addObject:appleWatchTransactionData];
    
    return nil;
}


@end
