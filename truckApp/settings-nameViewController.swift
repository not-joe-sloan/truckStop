//
//  settings-nameViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/19/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import Parse

class settings_nameViewController: UIViewController {


    @IBAction func savePressed(_ sender: Any) {
        
        let name = nameField.text
        
        
        let query = PFQuery(className: "Truck")
        query.whereKey("owner", equalTo: PFUser.current()?.value(forKey: "objectId"))

        query.getFirstObjectInBackground(block: { (truck, error) in
            if truck != nil{
                
                truck?.setValue(name, forKey: "truckName")
                
                truck?.saveInBackground(block: { (success, error) in
                    if success{
                        print("Success!")
                    }else{
                        Utils.showAlert(vc: self, title: "Error", message: error!.localizedDescription)
                    }
                })
                
            }
        })
        
    }
    
    @IBOutlet var nameField: UITextField!
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
