//
//  BRAWRootInterfaceController.swift
//  BreadWallet
//
//  Created by Henry on 10/19/15.
//  Copyright © 2015 Aaron Voisine. All rights reserved.
//

import WatchKit
import Foundation


class BRAWRootInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if self.shouldShowSetupWalletInterface() {
            WKInterfaceController.reloadRootControllersWithNames(["BRAWSetupWalletInterfaceController"], contexts: [])
        } else {
            WKInterfaceController.reloadRootControllersWithNames(["BRAWBalanceInterfaceController","BRAWReceiveMoneyInterfaceController"], contexts: [])
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func shouldShowSetupWalletInterface()->Bool {
        return false;
    }
    

}
