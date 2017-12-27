//
//  Truck.swift
//  truckApp
//
//  Created by Joe Sloan on 12/17/17.
//  Copyright © 2017 Joe Sloan. All rights reserved.
//

import UIKit
import CoreLocation

class Truck: NSObject {
    
    var truckId: String?
    
    //Basic Info
    var name: String?
    var city: String?
    var truckDescription: String?
    var email: String?
    var phone: String?
    var menuLink: String?
    var website: String?
    var twitter: String?
    var facebook: String?
    var instagram: String?
    var currentLocation: CLLocation?
    var currentLocationDescription: String?
    var isServing: Bool = false
    var menu = [menuItem]()
    var closingTime: NSDate?
    
    var dateJoined: NSDate?
    var lastLogin: NSDate?
    
    var lastServed: NSDate?
    var servingLog: [NSDate: servingLogEntry]?
    var frequentLocations: [frequentLocation]?
    
    struct frequentLocation {
        
        
        var lastVisited: servingLogEntry?
        var locationName: String?
        var timesVisited: Int?
        var locationCoordinates: CLLocationCoordinate2D?
        
        
    }
    
    struct servingLogEntry {
        var sessionId: String?
        var sessionDate: NSDate?
        var sessionBegan: String?
        var sessionEnded: String?
        var sessionLocation: CLLocationCoordinate2D?
        var customerVisits: Int?
    }
    
    //Defining a menu item
    struct menuItem {
        var itemId: String?
        var name: String?
        var description: String?
        var price: Float?
        struct categories: OptionSet {
            let rawValue: Int
            static let drinks = categories(rawValue: 1)
            static let appetizers = categories(rawValue: 2)
            static let entrees = categories(rawValue: 3)
            static let desserts = categories(rawValue: 4)
            static let specials = categories(rawValue: 5)
        }
        var category = menuItem.categories()
        
        struct allergyInfo {
            var peanuts = false
            var corn = false
            var gluten = false
            var sarcasm = false
        }
        
        
        var allergyInfo = menuItem.allergyInfo()
        
    }
    
    func goLive(){
        if name != nil && currentLocationDescription != nil {
            print("\(name!) is now serving at \(currentLocationDescription!)")
        }else if name != nil {
            print("\(name!) is serving now")
        }
        
    }
    
    func post(){
        
    }
    
    func addMenuItem(name: String, price: Float, description: String){
        var newItem = menuItem()
        newItem.name = name
        newItem.price = price
        newItem.description = description
        newItem.allergyInfo.peanuts = true
        newItem.allergyInfo.corn = true
        
        //Add drinks and desserts to categories
        
        //Add the new menu item
        menu.append(newItem)
        
    }

}
