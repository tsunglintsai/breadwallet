//
//  BRAWWatchDataManager.swift
//  BreadWallet
//
//  Created by Henry on 10/24/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

import WatchKit
import WatchConnectivity

class BRAWWatchDataManager: NSObject, WCSessionDelegate {
    static let sharedInstance = BRAWWatchDataManager()
    static let BalanceDidUpdateNotification = "BalanceDidUpdateNotification"
    static let ReceiveMoneyAddressDidUpdateNotification = "ReceiveMoneyAddressDidUpdateNotification"
    static let TransactionDidUpdateNotification = "ReceiveMoneyAddressDidUpdateNotification"
    private(set) var balance : NSString?;
    private(set) var balanceInLocalCurrency : NSString?
    private(set) var receiveMoneyAddress : NSString?
    private(set) var receiveMoneyQRCodeImage : UIImage?
    private(set) var transactionHistory = [BRAppleWatchTransactionData]()

    override init() {
        super.init()
        WCSession.defaultSession().delegate = self
        WCSession.defaultSession().activateSession()
        sendRequest()
    }
    
    func sendRequest() {
        let messageToSend = [AW_SESSION_REQUEST_DATA_TYPE_KEY:NSNumber(unsignedInt:AWSessionRquestDataTypeTransactions.rawValue)]
        WCSession.defaultSession().sendMessage(messageToSend, replyHandler: { [unowned self] replyMessage in
            //handle and present the message on screen
            print("\(replyMessage)")
            if let data = replyMessage[AW_SESSION_RESPONSE_KEY] as? NSData {
                if let appleWatchData = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BRAppleWatchData {
                    print(appleWatchData);
                    self.balance = appleWatchData.balance
                    self.balanceInLocalCurrency = appleWatchData.balanceInLocalCurrency
                    self.receiveMoneyAddress = appleWatchData.receiveMoneyAddress
                    self.receiveMoneyQRCodeImage = appleWatchData.receiveMoneyQRCodeImage
                    self.transactionHistory = appleWatchData.transactions
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.BalanceDidUpdateNotification, object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.ReceiveMoneyAddressDidUpdateNotification, object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.TransactionDidUpdateNotification, object: nil)
                    
                }
            }
            }, errorHandler: {error in
                // catch any errors here
                print(error)
        })
    }
    
    func simulateRemoveTransactions() {
        transactionHistory.removeLast()
        NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.TransactionDidUpdateNotification, object: nil)
    }
    
    func simulateAddTransactions() {
        let transactionData = BRAppleWatchTransactionData()
        transactionData.amount = "amount"
        transactionData.amountInLocalCurrency = "amount in local"
        transactionData.date = NSDate().description
        transactionHistory.insert(transactionData, atIndex: transactionHistory.count)
        NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.TransactionDidUpdateNotification, object: nil)
    }
}
