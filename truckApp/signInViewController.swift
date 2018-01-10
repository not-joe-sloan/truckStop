//
//  signInViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 1/9/18.
//  Copyright © 2018 Joe Sloan. All rights reserved.
//

import UIKit
import FacebookLogin

class signInViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passField: UITextField!
    @IBAction func signInPressed(_ sender: Any) {
        print("yay")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)

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
