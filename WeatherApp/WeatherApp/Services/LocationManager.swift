//
//  UserPermissionsService.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 12.01.2022.
//

import CoreLocation

protocol LocationManaging {
    func requestLocationPermission()
}

protocol LocationManagerOutput: AnyObject {
    func didUpdateLocation(location: CLLocation)
    func didUpdatePermission(status: CLAuthorizationStatus)
}

class LocationManager: NSObject {
    public weak var delegate: LocationManagerOutput?
    
    private let locationManager: CLLocationManager
    
    public private(set) var location: CLLocation? {
        didSet {
            if let location = location {
                delegate?.didUpdateLocation(location: location)
            }
        }
    }
    public private(set) var locationStatus = CLAuthorizationStatus.notDetermined {
        didSet {
            delegate?.didUpdatePermission(status: locationStatus)
        }
    }
    
    public override init() {
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status

        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            assertionFailure("Location hasn't updated")
            return
        }

        self.location = location
    }

    public func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension LocationManager: LocationManaging {
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}
