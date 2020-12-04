//
//  LocationManager.swift
//  ToolPool
//
//  Created by Giovanni Moya on 10/30/20.
//

import Foundation
import MapKit
import CoreLocation
import Combine
//responsible for getting the locaiton and updating the location

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
//    @Published var location: CLLocation? = nil
    //makes location a publisher variable, so whenever it updates, subscribers are alerted
    @Published var location: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    //published to all subscribers
    let objectWillChange = PassthroughSubject<Void, Never>()

    
    override init() {
        
        super.init()
        //set CLLocation manager
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        //ask user for permission, make sure plist is configured to ask user
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    func getUserLocation(completion: (_ lat: String, _ lng: String) -> Void) {
        var currentLocation: CLLocation!
        currentLocation = locationManager.location
        
        if currentLocation != nil {
            let latitude = String(format: "%.7f", currentLocation.coordinate.latitude)
            let longitude = String(format: "%.7f", currentLocation.coordinate.longitude)
            location = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)


            debugPrint("Latitude:", latitude)
            debugPrint("Longitude:", longitude)

            completion(latitude, longitude)  // your block of code you passed to this function will run in this way
        } else {
            let latitude = String(format: "%.7f", 37.781434)
            let longitude = String(format: "%.7f", -122.402411)
            location = CLLocation(latitude: 37.781434, longitude: -122.402411)
            completion(latitude, longitude)
        }

    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations status: CLAuthorizationStatus) {
        print(status)
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
    }
}
