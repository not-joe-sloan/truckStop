//
//  Utils.swift
//  truckApp
//
//  Created by Joe Sloan on 12/17/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Utils {
    static func showAlert(vc: UIViewController, title: String, message: String){
        
        let alert = UIAlertController()
        alert.title = title
        alert.message = message
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (nil) in
            alert.dismiss(animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    /*
    static func getTruck(id: String) -> Truck {

        let truckQuery = PFQuery(className: "Truck")
        truckQuery.getFirstObjectInBackground { (truck, error) in
            if error != nil {
                
            }else{
                let returnTruck = Truck()
                returnTruck.name = truck!.value(forKey: "name") as? String
                returnTruck.owner = truck!.value(forKey: "owner") as? String
                
                //return returnTruck
            }
        }
    
    }
 */
    
}


