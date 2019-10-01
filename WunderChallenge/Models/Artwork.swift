//
//  Artwork.swift
//  WunderChallenge
//
//  Created by Mohab Ayman on 9/29/19.
//  Copyright © 2019 Mohab Ayman. All rights reserved.
//

import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let fuel: Int
    let coordinate: CLLocationCoordinate2D
    
    var markerTintColor: UIColor  {
      switch fuel {
      case 0...40: return Keys.Colors.red1
      case 40...80: return Keys.Colors.orange1
      case 80...100: return Keys.Colors.deepspace
      default: return .gray
      }
    }
    
    init(title: String, locationName: String, fuel: Int, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.fuel = fuel
        self.coordinate = coordinate
        
        super.init()
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
      let addressDict = [CNPostalAddressStreetKey: locationName]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
}
