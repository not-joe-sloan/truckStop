//
//  User.swift
//  truckApp
//
//  Created by Joe Sloan on 12/17/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import CoreLocation

class User: NSObject {
    
    var dateJoined: NSDate?
    var lastLogin: NSDate?
    
    //User Info
    var userId: String?
    var name: String?
    var location: CLLocationCoordinate2D?
    
    //Truck Relations
    var favoriteTrucks = [Truck]()
    var favoriteMeals: [String : String]?
    var visitedTrucks: [String]?
    
    func findTrucks(userLocation: CLLocationCoordinate2D, searchRadius: Int) {
        print("Searching for trucks")
    }
    
    func navigateToTruck(currentLocation: CLLocationCoordinate2D, truck: Truck) {
        print("Navigating to the truck")
    }

}
