//
//  BRAWWatchDataManager.swift
//  BreadWallet
//
//  Created by Henry on 10/24/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

import WatchKit
import WatchConnectivity

enum WalletStatus {
    case HasSetup
    case NotSetup
    case CannotConnectToPhone
    case Unknown
}

class BRAWWatchDataManager: NSObject, WCSessionDelegate {
    static let sharedInstance = BRAWWatchDataManager()
    static let BalanceDidUpdateNotification = "BalanceDidUpdateNotification"
    static let ReceiveMoneyAddressDidUpdateNotification = "ReceiveMoneyAddressDidUpdateNotification"
    static let TransactionDidUpdateNotification = "ReceiveMoneyAddressDidUpdateNotification"
    static let GalanceDataDidUpdateNotification = "GalanceDataDidUpdateNotification"
    static let WalletStatusDidChangeNotification = "WalletStatusDidChangeNotification"

    private(set) var balance : String?;
    private(set) var balanceInLocalCurrency : String?
    private(set) var receiveMoneyAddress : String?
    private(set) var receiveMoneyQRCodeImage : UIImage?
    private(set) var transactionHistory = [BRAppleWatchTransactionData]()
    private(set) var lastestTransction : String?
    private(set) var walletStatus = WalletStatus.Unknown
    
    override init() {
        super.init()
        WCSession.defaultSession().delegate = self
        WCSession.defaultSession().activateSession()
    }
    
    func requestGalanceData() {
        let messageToSend = [AW_SESSION_REQUEST_DATA_TYPE_KEY:NSNumber(unsignedInt:AWSessionRquestDataTypeGlanceData.rawValue)]
        WCSession.defaultSession().sendMessage(messageToSend, replyHandler: { [unowned self] replyMessage in
                print("\(replyMessage)")
                if let data = replyMessage[AW_SESSION_RESPONSE_KEY] as? NSData {
                    if let appleWatchData = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BRAppleWatchData {
                        let previousWalletStatus = self.walletStatus
                        self.balance = appleWatchData.balance
                        self.balanceInLocalCurrency = appleWatchData.balanceInLocalCurrency
                        self.lastestTransction = appleWatchData.lastestTransction
                        if appleWatchData.hasWallet {
                            self.walletStatus = .HasSetup
                        } else {
                            self.walletStatus = .NotSetup
                        }
                        if self.walletStatus != previousWalletStatus {
                            NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.WalletStatusDidChangeNotification, object: nil)
                        }
                        NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.GalanceDataDidUpdateNotification, object: nil)
                    }
                }
            }, errorHandler: {error in
                self.walletStatus = .CannotConnectToPhone;
                NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.GalanceDataDidUpdateNotification, object: nil)
                // catch any errors here
                print(error)
            })
    }

    func requestAllData() {
        let messageToSend = [AW_SESSION_REQUEST_DATA_TYPE_KEY:NSNumber(unsignedInt:AWSessionRquestDataTypeAllData.rawValue)]
        WCSession.defaultSession().sendMessage(messageToSend, replyHandler: { [unowned self] replyMessage in
            //handle and present the message on screen
                print("\(replyMessage)")
                if let data = replyMessage[AW_SESSION_RESPONSE_KEY] as? NSData {
                    if let appleWatchData = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? BRAppleWatchData {
                        print(appleWatchData);
                        let previousWalletStatus = self.walletStatus
                        self.balance = appleWatchData.balance
                        self.balanceInLocalCurrency = appleWatchData.balanceInLocalCurrency
                        self.receiveMoneyAddress = appleWatchData.receiveMoneyAddress
                        self.receiveMoneyQRCodeImage = appleWatchData.receiveMoneyQRCodeImage
                        self.transactionHistory = appleWatchData.transactions
                        if appleWatchData.hasWallet {
                            self.walletStatus = .HasSetup
                        } else {
                            self.walletStatus = .NotSetup
                        }
                        NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.BalanceDidUpdateNotification, object: nil)
                        NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.ReceiveMoneyAddressDidUpdateNotification, object: nil)
                        NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.TransactionDidUpdateNotification, object: nil)
                        if self.walletStatus != previousWalletStatus {
                            NSNotificationCenter.defaultCenter().postNotificationName(BRAWWatchDataManager.WalletStatusDidChangeNotification, object: nil)
                        }
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
    
    func balanceAttributedString() -> NSAttributedString? {
       if let originalBalanceString = BRAWWatchDataManager.sharedInstance.balance {
            var balanceString = originalBalanceString.stringByReplacingOccurrencesOfString("ƀ"   , withString: "")
            balanceString = balanceString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return attributedStringForBalance(balanceString)
        }
        return nil
    }
    
    private func attributedStringForBalance(balance: String?)-> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.appendAttributedString(NSAttributedString(string: "ƀ", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()]))
        attributedString.appendAttributedString(NSAttributedString(string: balance ?? "0", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()]))
        return attributedString
    }
}
