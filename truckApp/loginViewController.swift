//
//  landingPage.swift
//  truckApp
//
//  Created by Joe Sloan on 12/17/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import Parse

class loginViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBAction func signupPressed(_ sender: Any) {
        
        if nameField.text != "" && nameField.text != nil {
            if passField.text != "" && passField.text != nil {

                let user = PFUser()
                user.username = nameField.text
                user.password = passField.text

                user["isOwner"] = false
                user["dateJoined"] = Date()
                user["lastLogin"] = Date()
                
                user.signUpInBackground(block: { (success, error) in
                    if success {
                        print("Success!")
                    }else{
                        Utils.showAlert(vc: self, title: "Error", message: error!.localizedDescription)
                    }
                })
                
            }
        }
        
    }
    @IBAction func truckSignupPressed(_ sender: Any) {
        if nameField.text != "" && nameField.text != nil {
            if passField.text != "" && passField.text != nil {
                
                let user = PFUser()
                user.username = nameField.text
                user.password = passField.text
                user["isOwner"] = true
                user["truck"] = String()
                user["dateJoined"] = Date()
                user["lastLogin"] = Date()
                

                
                user.signUpInBackground(block: { (success, error) in
                    if success {
                        print("Success")
                    }else{
                        Utils.showAlert(vc: self, title: "Error", message: error!.localizedDescription)
                    }
                })
                
                
                
                
                let truck = PFObject(className: "Truck")
                truck["owner"] = PFUser.current()?.value(forKey: "objectId")
                truck["dateJoined"] = Date()
                truck["lastLogin"] = Date()
                truck["isServing"] = false
                
                truck.saveInBackground(block: { (success, error) in
                    if success{
                        self.performSegue(withIdentifier: "truckOwnerLogin", sender: nil)
                        print("Success!")
                    }else{
                        Utils.showAlert(vc: self, title: "Error", message: error!.localizedDescription)
                    }
                })
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
