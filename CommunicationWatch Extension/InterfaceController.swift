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
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        // Activate the session on both sides to enable communication.
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate = self // conforms to WCSessionDelegate
            session.activate()
            print("Session ativada")
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
        
        let message = ["request": "fireLocalNotification"]
        print("preparar para enviar mensagem para iphone")
        WCSession.default().sendMessage(
            message, replyHandler: { (replyMessage) -> Void in
                print("Chegou: \(replyMessage)")
                if let mensagem: String = replyMessage["message"] as? String {
                    self.myLabel.setText(mensagem)
                } else {
                    self.myLabel.setText("")
                }
                
                
        }) { (error) -> Void in
            print(error.localizedDescription)
        }
      
    
    }
    
    // =========================================================================
    // MARK: - WCSessionDelegate
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        //print(session)
        print("reachable:\(session.isReachable)")
    }
    
    // Received message from iPhone
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    
        print("Received message from iPhone: \(message)")
        
        guard message["request"] as? String == "showAlert" else {return}
        
        let defaultAction = WKAlertAction(
            title: "OK",
            style: WKAlertActionStyle.default) { () -> Void in
        }
        let actions = [defaultAction]
        self.presentAlert(withTitle: "Message Received", message: "", preferredStyle: WKAlertControllerStyle.alert, actions: actions)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        print("ActivationState: \(activationState.rawValue.description) === \(activationState.hashValue.description)")

    }
    
    

}

