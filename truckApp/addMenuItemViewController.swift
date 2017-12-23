    //
//  addMenuItemViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/22/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit

class addMenuItemViewController: UIViewController{

    @IBOutlet var itemNameField: UITextField!
    @IBOutlet var itemPriceField: UITextField!
    @IBOutlet var itemDescriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemDescriptionField.layer.cornerRadius = 5
        itemDescriptionField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        itemDescriptionField.layer.borderWidth = 0.5
        itemDescriptionField.clipsToBounds = true

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
