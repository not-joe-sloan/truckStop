//
//  search- mainViewController.swift
//  truckApp
//
//  Created by Joe Sloan on 12/27/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import MapKit

class search__mainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    
    
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchScopeSlider: UISlider!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapListbutton: UIBarButtonItem!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBAction func searchWasPressed(_ sender: Any) {
        searchButton.alpha = 0.6
        
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
        let latitude: CLLocationDegrees = 40.018888
        let longitude: CLLocationDegrees = -105.275319
        
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

        searchButton.alpha = 0.6
        searchScopeSlider.isContinuous = false
        
        //Set a center Point
        let latitude: CLLocationDegrees = 40.018888
        let longitude: CLLocationDegrees = -105.275319
        
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


        // Do any additional setup after loading the view.
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
