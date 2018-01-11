//
//  signInViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 1/9/18.
//  Copyright © 2018 Joe Sloan. All rights reserved.
//

import UIKit
import Parse
import FacebookLogin
import FacebookCore

class signInViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBAction func signInPressed(_ sender: Any) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                } else {
                    print("User logged in through Facebook!")
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
    }
    
    
    @objc func loginButtonClicked() {
        
        let loginManager = LoginManager()
        
        
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { (result) in
            switch result {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.blue
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("My Login Button", for: [])
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        
        

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
