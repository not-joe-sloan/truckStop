//
//  search- mainViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/27/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import MapKit

class search__mainViewController: UIViewController {
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapListbutton: UIBarButtonItem!
    
    var isListView = true
    
    func tableTheMap(){
        
        if isListView {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.alpha = 0
                self.tableView.isUserInteractionEnabled = false
            })
            
            isListView = false
            
            mapListbutton.title = "List"
            
        }else{
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.alpha = 1
                self.tableView.isUserInteractionEnabled = true
            })
            
            isListView = true
            mapListbutton.title = "Map"
            
        }
        
    }
    
    @IBAction func tableTheMap(_ sender: Any) {
        tableTheMap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let textFieldInsideSearchBar = self.searchbar.value(forKey: "searchField") as? UITextField,

            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            
            if textFieldInsideSearchBar.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
                let attributeDict = [NSAttributedStringKey.foregroundColor: UIColor.white]
                textFieldInsideSearchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributeDict)
            }
            
            //Magnifying glass
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .white
            
            textFieldInsideSearchBar.textColor = UIColor.white
            
        }
 


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
