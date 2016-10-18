//
//  InterfaceController.swift
//  CommunicationWatch Extension
//
//  Created by Daniel Rocha on 17/10/16.
//  Copyright © 2016 Daniel Rocha. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    private var counter = 5
    
    @IBOutlet var myLabel: WKInterfaceLabel!
    
    private let session : WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    override init() {
        super.init()
        
        session?.delegate = self
        session?.activate()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            myLabel.setText(name)
        } else {
            myLabel.setText("testando")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func buscar() {
        let applicationData = ["counterValue" : counter]
        
        // The paired iPhone has to be connected via Bluetooth.
        if let session = session , session.isReachable {
            session.sendMessage(applicationData,
                                replyHandler: { replyData in
                                    // handle reply from iPhone app here
                                    print("Daniel: \(replyData)")
                }, errorHandler: { error in
                    // catch any errors here
                    print(error)
            })
        } else {
            // when the iPhone is not connected via Bluetooth
            print("iPhone is not connected via Bluetooth")
        }

    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("chegou aqui2")
    }
    
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        //dispatch_async(dispatch_get_main_queue()) {
        //if let counterValue = message["counterValue"] as? Int {
        //self.counterData.append(counterValue)
        //self.mainTableView.reloadData()
        print("chegou aqui")
        //}
        //}
    }

}

