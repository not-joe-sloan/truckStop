//
//  activity-activityViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/26/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import MapKit
import Parse

class activity_activityViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    var isActive = false

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var activityStatusButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tabBarController?.tabBar.items![0].badgeColor = globalConstants.mainOrange
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let imageBox = UIImageView()
        imageBox.image = UIImage(named: "facebook-icon-round.png")
        
        imageBox.center = self.mapView.center
        view.addSubview(imageBox)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        self.currentLocation = userLocation
        //Set a center Point
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        //Set a zoom level
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        //Create the components for a region - your centerpoint and your zoom level
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //Combine components into an actual region
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        //Display our region on the map
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func changeActivityStatus(_ sender: Any) {
        
        if isActive == false{
            
            let point = PFGeoPoint(latitude: 1.1, longitude: 1.1)
            
            activityStatusButton.title = "Deactivate"
            self.title = "Active"
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.tableView.alpha = 1
            })
            
            self.mapView.isZoomEnabled = true;
            self.mapView.isScrollEnabled = true;
            self.mapView.isUserInteractionEnabled = true;
            self.tableView.isUserInteractionEnabled = true
            self.mapView.showsUserLocation = true
            
            self.tabBarController?.tabBar.items![0].title = "Active"
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.navigationController?.navigationBar.barTintColor = globalConstants.activeGreen
            })
            isActive = true
        }else{
            isActive = false
            activityStatusButton.title = "Start Serving"
            self.title = "Inactive"
            self.tabBarController?.tabBar.items![0].title = "Inactive"
            self.tabBarController?.tabBar.items![0].badgeColor = globalConstants.mainOrange
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.navigationController?.navigationBar.barTintColor = globalConstants.mainOrange
            })
            
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
                self.tableView.alpha = 0.2
                
            })
            
            self.tableView.isUserInteractionEnabled = false
            self.mapView.isZoomEnabled = false;
            self.mapView.isScrollEnabled = false;
            self.mapView.isUserInteractionEnabled = false;
            
            self.mapView.showsUserLocation = false
            
            
            
        }
        
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
