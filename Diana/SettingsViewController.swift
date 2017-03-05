//
//  SettingsViewController.swift
//  Diana
//
//  Created by Ricardo Riosalido on 3/3/17.
//  Copyright © 2017 Ricardo Riosalido. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var SelectDiana: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tipoDiana = userDefaults.string(forKey: "Diana")!
        var indice = 0
        switch tipoDiana {
        case "Fita":
            indice = 0
            break;
        case "Fita-6":
            indice = 1
            break;
        case "Fita-5":
            indice = 2
            break;
        default:
            indice = 0
            break
        }
        
        SelectDiana.selectedSegmentIndex =  indice
        //userDefaults.string(forKey: "Diana")!        // Do any dditional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func SelectDiana(_ sender: UISegmentedControl) {
        
        switch (self.SelectDiana.selectedSegmentIndex)   {
            
        case 0:
            userDefaults.set("Fita", forKey: "Diana")

            break;
        case 1:
            userDefaults.set("Fita-6", forKey: "Diana")

            break;
        case 2:
            userDefaults.set("Fita-5", forKey: "Diana")
            break;
        default:
            //userDefaults.set("Fita", forKey: "Diana")
            break
        }
       
    }
    
    
    @IBAction func go(_ sender: UIButton) {
        
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     
    
}
