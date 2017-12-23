//
//  settings-truckPhoneViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/22/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import Parse

class settings_truckPhoneViewController: UIViewController {
    
    @IBOutlet var phoneField: UITextField!
    
    @IBAction func savePressed(_ sender: Any) {
        
        let phone = phoneField.text
        
        let query = PFQuery(className: "Truck")
        
        query.whereKey("owner", equalTo: PFUser.current()?.value(forKey: "objectId") as Any)
        
        query.getFirstObjectInBackground(block: { (truck, error) in

            if truck != nil{
                
                truck?.setValue(phone, forKey: "truckPhone")
                
                truck?.saveInBackground(block: { (success, error) in
                    if success{
                        
                        Utils.showAlert(vc: self, title: "Saved", message: "Your save was a success!")
                    }else{
                        Utils.showAlert(vc: self, title: "Error", message: error!.localizedDescription)
                    }
                })
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
