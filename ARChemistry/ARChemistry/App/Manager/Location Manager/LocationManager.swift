//
//  LocationManager.swift
//  TiffsTreats
//
//  Created by Jasdeep Saini on 2/16/17.
//  Copyright © 2017 Mutual Mobile. All rights reserved.
//

import UIKit
import CoreLocation

extension Notification.Name {
    static let locationAuthorizationStatusDidChange = Notification.Name("locationAuthorizationDidChange")
}

typealias NorthEastCoordinate = CLLocationCoordinate2D
typealias SouthWestCoordinate = CLLocationCoordinate2D
typealias LocationBounds = (NorthEastCoordinate, SouthWestCoordinate)

typealias LocationManagerAuthorizationCallback = (CLAuthorizationStatus) -> ()

/// An interface for getting the user's location.
protocol LocationManager {
    
    func shouldRequestLocationPermission() -> Bool
    func isAuthorized() -> Bool
    func requestLocationPermission(completion: LocationManagerAuthorizationCallback?)

    func currentLocationBounds() -> LocationBounds?
    func currentLocation() -> CLLocation?
}











//MARK: - LocationManager_
class LocationManager_: NSObject, LocationManager {
    fileprivate let locationManager = CLLocationManager()
    
    var requestingLocationCompletionCallbacks = [LocationManagerAuthorizationCallback]();
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func shouldRequestLocationPermission() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        
        return status == .notDetermined
    }
    
    func isAuthorized() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
    func requestLocationPermission(completion: LocationManagerAuthorizationCallback?) {
        if let callback = completion,
            CLLocationManager.authorizationStatus() == .notDetermined{
            requestingLocationCompletionCallbacks.append(callback);
        }
        locationManager.requestWhenInUseAuthorization()
    }
    
    func currentLocationBounds() -> LocationBounds? {
        guard let latitude = locationManager.location?.coordinate.latitude, let longitude = locationManager.location?.coordinate.longitude else {
            return nil
        }
        
        let latitudeDelta = 3.0
        let longitudeDelta = 3.0
        let northEast = CLLocationCoordinate2D(latitude: latitude + latitudeDelta, longitude: longitude + longitudeDelta)
        let southWest = CLLocationCoordinate2D(latitude: latitude - latitudeDelta, longitude: longitude - longitudeDelta)
        
        return (northEast, southWest)
    }
    
    func currentLocation() -> CLLocation? {
        return locationManager.location
    }
}


//MARK: - LocationManager_ - CLLocationManagerDelegate
extension LocationManager_: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        NotificationCenter.default.post(name: Notification.Name.locationAuthorizationStatusDidChange, object: nil)
        
        if status != .notDetermined {
            for callback in requestingLocationCompletionCallbacks {
                callback(status);
            }
            requestingLocationCompletionCallbacks.removeAll();
        }
    }
}
