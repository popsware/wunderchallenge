//
//  Car.swift
//  WunderChallenge
//
//  Created by Mohab Ayman on 9/29/19.
//  Copyright © 2019 Mohab Ayman. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

class Car: NSObject {
    
    var address: String
    var coordinates: [Double]
    var engineType: String
    var exterior: String
    var fuel: Int
    var interior: String
    var name: String
    var vin: String
    
    
    init(randomid: Int) {
        
        self.address = "Lesserstraße 170, 22049 Hamburg"
        self.coordinates = [10.07526, 53.59301, 0]
        self.engineType = "CE"
        self.exterior = "UNACCEPTABLE"
        self.fuel = 42
        self.interior = "UNACCEPTABLE"
        self.name = "HH-GO8522"
        self.vin =  "WME4513341K565439"
        
    }
    
    override public var description: String { return "Car\(name)" }
    
    
    init(dictionary: JSON) throws {
        //print(dictionary)
        
        
        if let address = dictionary["address"].string,
            let coordinatesList = dictionary["coordinates"].array,
            let engineType = dictionary["engineType"].string,
            let exterior = dictionary["exterior"].string,
            let fuel = dictionary["fuel"].int,
            let interior = dictionary["interior"].string,
            let name = dictionary["name"].string,
            let vin = dictionary["vin"].string
        {
            
            self.address = address
            self.engineType = engineType
            self.exterior = exterior
            self.fuel = fuel
            self.interior = interior
            self.name = name
            self.vin = vin
            
            
            self.coordinates = []
            //if the key was not found in the dictionary, the loop will not start (no crashing)
            for subJson:JSON in coordinatesList {
                
                if let coordinates = subJson.double{
                    self.coordinates.append(coordinates)
                }
                else{
                    print("coordinates object came incorrect from API")
                    throw NSError(domain: "object error", code: 42, userInfo: ["object":"coordinates"] )
                    
                }
            }
        }
        else {
            print("car object came incorrect from API")
            throw NSError(domain: "object error", code: 42, userInfo: ["object": "car"] )
        }
        
    }
    
    func getCoordinates() throws -> CLLocation {
        if coordinates.count > 2{
            return CLLocation(latitude:  coordinates[1], longitude:  coordinates[0])
        }else{
            print("coordinates are not complete")
            throw NSError(domain: "object error", code: 42, userInfo: ["object":"coordinates"] )
        }
    }
    func getCLLocationCoordinate2D() throws -> CLLocationCoordinate2D {
        if coordinates.count > 2{
            return CLLocationCoordinate2D(latitude:  coordinates[1], longitude:  coordinates[0])
        }else{
            print("coordinates are not complete")
            throw NSError(domain: "object error", code: 42, userInfo: ["object":"coordinates"] )
        }
    }
}

