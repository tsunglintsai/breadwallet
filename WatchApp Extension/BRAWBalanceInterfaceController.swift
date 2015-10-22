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
        table.setNumberOfRows(1, withRowType: "BRAWBalanceRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 1), withRowType: "BRAWTransactionHeaderRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 2), withRowType: "BRAWTransactionRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 3), withRowType: "BRAWTransactionRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 4), withRowType: "BRAWTransactionRowControl")
        table.insertRowsAtIndexes(NSIndexSet(index: 5), withRowType: "BRAWTransactionRowControl")
        
        var rowControlEvent = table.rowControllerAtIndex(2) as! BRAWTransactionRowControl
        rowControlEvent.amountLabel.setText("-ƀ10994")
        rowControlEvent.localCurrencyAmount.setText("-$3.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = true

        rowControlEvent = table.rowControllerAtIndex(3) as! BRAWTransactionRowControl
        rowControlEvent.amountLabel.setText("ƀ7329")
        rowControlEvent.localCurrencyAmount.setText("$2.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = false
        
        rowControlEvent = table.rowControllerAtIndex(4) as! BRAWTransactionRowControl
        rowControlEvent.amountLabel.setText("ƀ36647")
        rowControlEvent.localCurrencyAmount.setText("$10.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = false
        
        rowControlEvent = table.rowControllerAtIndex(5) as! BRAWTransactionRowControl
        rowControlEvent.amountLabel.setText("-ƀ21988")
        rowControlEvent.localCurrencyAmount.setText("-$6.00")
        rowControlEvent.seperatorGroup.setHeight(0.5)
        rowControlEvent.isSendMoney = true
        
        let rowControlBalance = table.rowControllerAtIndex(0) as! BRAWBalanceRowControl
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
