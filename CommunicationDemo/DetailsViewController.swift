//
//  DetailsViewController.swift
//  CommunicationDemo
//
//  Created by Daniel Rocha on 17/10/16.
//  Copyright © 2016 Daniel Rocha. All rights reserved.
//

import UIKit
import WatchConnectivity

class DetailsViewController: UIViewController {

    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureWCSession()
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configureWCSession()
    }
    
    private func configureWCSession() {
        session?.delegate = self
        session?.activate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            nameLabel.text = "\(name)"
        }
        
        if let pass = UserDefaults.standard.value(forKey: "pass") {
            passLabel.text = "\(pass)"
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        UserDefaults.standard.set(nil, forKey: "name")
        UserDefaults.standard.set(nil, forKey: "pass")
        UserDefaults.standard.set(false, forKey: "logged")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: WCSessionDelegate
extension DetailsViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        //dispatch_async(dispatch_get_main_queue()) {
        //if let counterValue = message["counterValue"] as? Int {
        //self.counterData.append(counterValue)
        //self.mainTableView.reloadData()
        print("chegou")
        //}
        //}
    }
}
