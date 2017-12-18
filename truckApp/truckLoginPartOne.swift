//
//  truckLoginPartOne.swift
//  truckApp
//
//  Created by Joe Sloan on 12/17/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import Parse

class truckLoginPartOne: UIViewController {

    @IBOutlet var truckNameField: UITextField!
    @IBOutlet var truckWebsiteField: UITextField!
    @IBOutlet var truckEmailField: UITextField!
    @IBOutlet var truckPhoneField: UILabel!
    
    var currentUser = PFUser.current()
    
    
    
    @IBAction func nextPressed(_ sender: Any) {

        let newTruck = PFObject(className:"Truck")
        newTruck["truckOwner"] = currentUser?.objectId
        newTruck["truckName"] = truckNameField.text
        newTruck["truckWebsite"] = truckWebsiteField.text
        newTruck["truckEmail"] = truckEmailField.text
        newTruck["truckPhone"] = truckPhoneField.text
        newTruck.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                self.performSegue(withIdentifier: "truckLogin2", sender: nil)
            } else {
                // There was a problem, check error.description
            }
        }

        
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
