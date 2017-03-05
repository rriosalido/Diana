//
//  ViewController.swift
//  Diana
//
//  Created by Ricardo Riosalido on 26/2/17.
//  Copyright © 2017 Ricardo Riosalido. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    
    let userDefaults = UserDefaults.standard
    var tipoDiana = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
           tipoDiana = (userDefaults.string(forKey: "Diana")!)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


