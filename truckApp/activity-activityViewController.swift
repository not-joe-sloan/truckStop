//
//  activity-activityViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/26/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import MapKit

class activity_activityViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var isActive = false

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var activityStatusButton: UIBarButtonItem!
    @IBAction func changeActivityStatus(_ sender: Any) {
        
        if isActive == false{
            
            activityStatusButton.title = "Deactivate"
            self.title = "Active"
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.mapView.alpha = 1
                self.tableView.alpha = 1
            })
            
            self.mapView.isZoomEnabled = true;
            self.mapView.isScrollEnabled = true;
            self.mapView.isUserInteractionEnabled = true;
            self.tableView.isUserInteractionEnabled = true
            
            self.tabBarController?.tabBar.items![0].title = "Active"
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.navigationController?.navigationBar.barTintColor = globalConstants.activeGreen
            })
            isActive = true
        }else{
            isActive = false
            activityStatusButton.title = "Activate"
            self.title = "Inactive"
            self.tabBarController?.tabBar.items![0].title = "Inactive"
            self.tabBarController?.tabBar.items![0].badgeColor = globalConstants.mainOrange
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.navigationController?.navigationBar.barTintColor = globalConstants.mainOrange
            })
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.mapView.alpha = 0.2
                self.tableView.alpha = 0.2
            })
            
            self.tableView.isUserInteractionEnabled = false
            self.mapView.isZoomEnabled = false;
            self.mapView.isScrollEnabled = false;
            self.mapView.isUserInteractionEnabled = false;
            
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.items![0].badgeColor = globalConstants.mainOrange

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timeCell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        let socialCell = tableView.dequeueReusableCell(withIdentifier: "socialCell", for: indexPath)
        
        if indexPath.section == 0 {
            return timeCell
        }else {
            return socialCell
        }
        
        
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