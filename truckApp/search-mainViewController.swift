//
//  search- mainViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/27/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import MapKit

class search__mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    
    @IBOutlet var zipButton: UIBarButtonItem!
    @IBAction func zip(_ sender: Any) {
        let zipAlert = UIAlertController(title: "Change Zip", message: "Enter a zip to search in.", preferredStyle: .alert)
        
        zipAlert.addTextField { (textField) in
            
            textField.placeholder = "Enter a zip"
        }
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            let zipField = zipAlert.textFields![0] as UITextField
            zipField.keyboardType = UIKeyboardType.numbersAndPunctuation
            
            if zipAlert.textFields![0].text == ""{
                
            }else{
                
                self.searchButton.alpha = 0.6
                
                let address = zipField.text
                
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(address!) { (placemarks, error) in
                    guard
                        let placemarks = placemarks,
                        let location = placemarks.first?.location
                        else {
                            // handle no location found
                            return
                    }
                    
                    //Set a center Point
                    let latitude: CLLocationDegrees = location.coordinate.latitude
                    let longitude: CLLocationDegrees = location.coordinate.longitude
                    
                    //Set a zoom level
                    let latDelta: CLLocationDegrees = (Double(self.searchScopeSlider.value)/100)
                    let lonDelta: CLLocationDegrees = (Double(self.searchScopeSlider.value)/100)
                    
                    //Create the components for a region - your centerpoint and your zoom level
                    let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                    
                    let loocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    
                    //Combine components into an actual region
                    let region: MKCoordinateRegion = MKCoordinateRegionMake(loocation, span)
                    
                    //Display our region on the map
                    self.mapView.setRegion(region, animated: true)
                    
                    // Use your location
                }
                self.zipButton.title = "in " + zipField.text!
            }
        }
        
        zipAlert.addAction(okAction)
        
        self.present(zipAlert, animated: true, completion: nil)
    }
    
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchScopeSlider: UISlider!
    var spanDeltaVal = Double()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapListbutton: UIBarButtonItem!
    
    func changeZip(){
        
        
        
    }
    
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.spanDeltaVal = (Double(searchScopeSlider.value)/100)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        
        searchButton.alpha = 0.6
        searchScopeSlider.isContinuous = false
        
        
        
        
 
         
        
        
        // Do any additional setup after loading the view.
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
    
    
    func getZip() -> String {
        
        var postalCode = String()
        
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if placemarks?.count != 0 {
                let pm = placemarks![0]
                print(pm.postalCode!)
                postalCode = pm.postalCode! as String
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        
        return postalCode
    }
    
    
    @IBAction func searchWasPressed(_ sender: Any) {
        searchButton.alpha = 0.6
        
        let address = "91902"
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            //Set a center Point
            let latitude: CLLocationDegrees = location.coordinate.latitude
            let longitude: CLLocationDegrees = location.coordinate.longitude
            
            //Set a zoom level
            let latDelta: CLLocationDegrees = (Double(self.searchScopeSlider.value)/100)
            let lonDelta: CLLocationDegrees = (Double(self.searchScopeSlider.value)/100)
            
            //Create the components for a region - your centerpoint and your zoom level
            let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            let loocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            //Combine components into an actual region
            let region: MKCoordinateRegion = MKCoordinateRegionMake(loocation, span)
            
            //Display our region on the map
            self.mapView.setRegion(region, animated: true)
            
            // Use your location
        }
        
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        if Int(searchScopeSlider.value) == 1 {
            searchButton.setTitle("WITHIN \(Int(searchScopeSlider.value)) MILE", for: .normal)
        }else if Int(searchScopeSlider.value) > 24 {
            searchButton.setTitle("SO HUNGRY", for: .normal)
        }else{
            searchButton.setTitle("WITHIN \(Int(searchScopeSlider.value)) MILES", for: .normal)
        }
        
       searchButton.alpha = 1
        

        //Set a center Point
        let latitude: CLLocationDegrees = currentLocation.coordinate.latitude
        let longitude: CLLocationDegrees = currentLocation.coordinate.longitude
        
        //Set a zoom level
        let latDelta: CLLocationDegrees = (Double(searchScopeSlider.value)/100)
        let lonDelta: CLLocationDegrees = (Double(searchScopeSlider.value)/100)
        
        //Create the components for a region - your centerpoint and your zoom level
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //Combine components into an actual region
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        //Display our region on the map
        mapView.setRegion(region, animated: true)
        
    }
    
    
    var isListView = true
    
    func tableTheMap(){
        
        print("Test")
        
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
    
    
    
// MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return cell
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
