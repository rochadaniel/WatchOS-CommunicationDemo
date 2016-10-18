//
//  ViewController.swift
//  CommunicationDemo
//
//  Created by Daniel Rocha on 17/10/16.
//  Copyright © 2016 Daniel Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            passLabel.text = name
        } else {
            passLabel.text = "test"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: AnyObject) {
        UserDefaults.standard.set(nameLabel.text, forKey: "name")
        UserDefaults.standard.set(passLabel.text, forKey: "pass")
        UserDefaults.standard.set(true, forKey: "logged")
        UserDefaults.standard.synchronize()
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        
        self.navigationController?.pushViewController(secondViewController!, animated: true)
        
    }
    

}

