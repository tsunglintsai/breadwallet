//
//  BRAWGlanceInterfaceController.swift
//  BreadWallet
//
//  Created by Henry on 10/22/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

import WatchKit

class BRAWGlanceInterfaceController: WKInterfaceController {
    
    @IBOutlet var balanceAmountLabel: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.balanceAmountLabel.setAttributedText(attributedString())
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func attributedString()-> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.appendAttributedString(NSAttributedString(string: "ƀ", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()]))
        attributedString.appendAttributedString(NSAttributedString(string: "1,000,000", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()]))
        return attributedString
    }
    
}