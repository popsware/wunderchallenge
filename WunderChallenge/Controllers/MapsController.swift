//
//  MapsController.swift
//  WunderChallenge
//
//  Created by Mohab Ayman on 9/29/19.
//  Copyright © 2019 Mohab Ayman. All rights reserved.
//

import UIKit
import MapKit

class MapsController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    var car: Car?
    var cars: [Car]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        
        //TODO: now a big todo here is to investigate whether i should use google maps or not
        displayData()
        
    }
    
    func displayData() {
        do
        {
            if let car = car{
                try displayCar(car)
            }
            else if let cars = cars
            {
                try displayCars(cars)
            }
            else{
                throw NSError(domain: "unexpected case, you should sent either the array list or the object", code: 0, userInfo: nil)
            }
        }
        catch{
            let alert = UIAlertController(title: Keys.Messages.somethingwrong, message: Keys.Messages.trylater, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    ///display one car on the maps
    func displayCar(_ car: Car) throws{
        try self.addCarMarker(car)
        self.centerMapOnLocation(location: try car.getCoordinates(), regionRadius: 1000)
    }
    
    ///displaying all cars
    func displayCars(_ cars: [Car]) throws{
        var centerCoordinates: CLLocation?
        for car in cars
        {
            try self.addCarMarker(car)
            centerCoordinates = self.calculateCenter(location1: centerCoordinates, location2: try car.getCoordinates())
        }
        
        if let centerCoordinates = centerCoordinates
        {
            self.centerMapOnLocation(location: centerCoordinates, regionRadius: 10000)
        }
        else{
            throw NSError(domain: "random error to fall into the catch", code: 0, userInfo: nil)
            
        }
    }
    
    
    /// centers the map to this location
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    ///adds a marker to the map
    func addCarMarker(_ car: Car) throws
    {
        let artwork = Artwork(title: car.name,
                              locationName: car.address,
                              fuel: car.fuel,
                              coordinate: try car.getCLLocationCoordinate2D())
        mapView.addAnnotation(artwork)
    }
    
    ///returns the center point between two locations
    func calculateCenter(location1: CLLocation?, location2: CLLocation) -> CLLocation{
        if let location1 = location1 {
            let avg_latitude = (location1.coordinate.latitude + location2.coordinate.latitude) / 2
            let avg_longitude = (location1.coordinate.longitude + location2.coordinate.longitude) / 2
            return CLLocation(latitude: avg_latitude, longitude: avg_longitude)
        }
        else{
            return location2
        }
    }
    
    @IBAction func closeTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension MapsController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Artwork else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.markerTintColor = annotation.markerTintColor
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        (location.mapItem() as AnyObject).openInMaps(launchOptions: launchOptions)
    }
}
