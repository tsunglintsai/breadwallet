//
//  BRAWBalanceInterfaceController.swift
//  BreadWallet
//
//  Created by Henry on 10/19/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

import WatchKit
import Foundation


class BRAWBalanceInterfaceController: WKInterfaceController {
    @IBOutlet var table: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.mockData()
    }
    
    
    func mockData() {
        table.setNumberOfRows(1, withRowType: "BRBalanceRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 1), withRowType: "BRTransactionHeaderRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 2), withRowType: "BRTransactionRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 3), withRowType: "BRTransactionRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 4), withRowType: "BRTransactionRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 5), withRowType: "BRTransactionRowControl")
        
        var rowControlEvent = table.rowControllerAtIndex(2) as! BRTransactionRowControl
        rowControlEvent.amountLabel.setText("-ƀ10994")
        rowControlEvent.localCurrencyAmount.setText("-$3.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = true

        rowControlEvent = table.rowControllerAtIndex(3) as! BRTransactionRowControl
        rowControlEvent.amountLabel.setText("ƀ7329")
        rowControlEvent.localCurrencyAmount.setText("$2.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = false
        
        rowControlEvent = table.rowControllerAtIndex(4) as! BRTransactionRowControl
        rowControlEvent.amountLabel.setText("ƀ36647")
        rowControlEvent.localCurrencyAmount.setText("$10.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = false
        
        rowControlEvent = table.rowControllerAtIndex(5) as! BRTransactionRowControl
        rowControlEvent.amountLabel.setText("-ƀ21988")
        rowControlEvent.localCurrencyAmount.setText("-$6.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = true
        
        let rowControlBalance = table.rowControllerAtIndex(0) as! BRBalanceRowControl
        rowControlBalance.bitBalance.setAttributedText(self.attributedString())

    }
    
    func attributedString()-> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.appendAttributedString(NSAttributedString(string: "ƀ", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()]))
        attributedString.appendAttributedString(NSAttributedString(string: "1,000,000", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()]))
        return attributedString
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
