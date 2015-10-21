//
//  BRTransactionRowControl.swift
//  BreadWallet
//
//  Created by Henry on 10/15/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

import WatchKit
import Foundation


class BRTransactionRowControl: NSObject {

    @IBOutlet var sendIcon: WKInterfaceImage!
    @IBOutlet var receiveIcon: WKInterfaceImage!
    @IBOutlet var amountLabel: WKInterfaceLabel!
    @IBOutlet var dateLabel: WKInterfaceLabel!
    @IBOutlet var seperatorGroup: WKInterfaceGroup!
    @IBOutlet var localCurrencyAmount: WKInterfaceLabel!
    
    var isSendMoney = false {
        didSet {
            self.sendIcon.setHidden(!isSendMoney)
            self.receiveIcon.setHidden(isSendMoney)
        }
    }
    
}
