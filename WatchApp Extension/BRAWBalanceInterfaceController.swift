//
//  TodayViewController.m
//  TodayWidget
//
//  Created by Henry on 6/14/15.
//  Copyright (c) 2015 Aaron Voisine <voisine@gmail.com>
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

import WatchKit

class BRAWBalanceInterfaceController: WKInterfaceController {
    @IBOutlet var table: WKInterfaceTable!
    var transactionList = [BRAppleWatchTransactionData]()

    @IBOutlet var balanceTextContainer: WKInterfaceGroup!
    @IBOutlet var balanceLoadingIndicator: WKInterfaceGroup!
    @IBOutlet var balanceLabel: WKInterfaceLabel!
    @IBOutlet var balanceInLocalCurrencyLabel: WKInterfaceLabel!
    @IBOutlet var transactionHeaderContainer: WKInterfaceGroup! {
        didSet {
            transactionHeaderContainer.setHidden(true) // hide header as default
        }
    }
    
    var showBalanceLoadingIndicator = false {
        didSet{
            self.balanceTextContainer.setHidden(showBalanceLoadingIndicator)
            self.balanceLoadingIndicator.setHidden(!showBalanceLoadingIndicator)
        }
    }
    
    // MARK: View life cycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        updateBalance()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateBalance()
        updateTransactionList()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateBalance", name: BRAWWatchDataManager.BalanceDidUpdateNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTransactionList", name: BRAWWatchDataManager.TransactionDidUpdateNotification, object: nil)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: UI update
    
    func updateBalance() {
        if let balanceInLocalizationString = BRAWWatchDataManager.sharedInstance.balanceInLocalCurrency as String?, let originalBalanceString = BRAWWatchDataManager.sharedInstance.balance as? String {
            var balanceString = originalBalanceString.stringByReplacingOccurrencesOfString("ƀ"   , withString: "")
            balanceString = balanceString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            balanceLabel.setAttributedText(attributedStringForBalance(balanceString))
            balanceInLocalCurrencyLabel.setText(balanceInLocalizationString)
            showBalanceLoadingIndicator = false;
        } else {
            showBalanceLoadingIndicator = true;
        }
    }
    
    func updateTransactionList() {
        transactionList = BRAWWatchDataManager.sharedInstance.transactionHistory
        let currentTableRowCount = table.numberOfRows
        let newTransactionCount = transactionList.count
        let numberRowsToInsertOrDelete = newTransactionCount - currentTableRowCount
        self.transactionHeaderContainer.setHidden(newTransactionCount == 0)
        // insert or delete rows to match number of transactions
        if (numberRowsToInsertOrDelete > 0) {
            table.insertRowsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(currentTableRowCount, numberRowsToInsertOrDelete)), withRowType: "BRAWTransactionRowControl")
        } else {
            table.removeRowsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(newTransactionCount, abs(numberRowsToInsertOrDelete))))
        }
        // update row content
        for var index = 0; index < newTransactionCount; index++  {
            if let rowControl = table.rowControllerAtIndex(index) as? BRAWTransactionRowControl {
                updateRow(rowControl, transaction: self.transactionList[index])
            }
        }
    }
    
    func updateRow(rowControl: BRAWTransactionRowControl, transaction: BRAppleWatchTransactionData) {
        rowControl.amountLabel.setText(transaction.amount)
        rowControl.localCurrencyAmount.setText(transaction.amountInLocalCurrency)
        rowControl.dateLabel.setText(transaction.date)
        rowControl.isSendMoney = true
        rowControl.seperatorGroup.setHeight(0.5)
    }
    
    // MARK: Helper methods
    
    func attributedStringForBalance(balance: String?)-> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.appendAttributedString(NSAttributedString(string: "ƀ", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()]))
        attributedString.appendAttributedString(NSAttributedString(string: balance ?? "0", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()]))
        return attributedString
    }

}
