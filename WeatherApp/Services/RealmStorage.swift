//
//  RealmStorage.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 24.01.2022.
//

import RealmSwift
import CoreLocation

// TODO: Add file
class UserLocationData: Object {
    @Persisted(primaryKey: true) var id: Int = 1

    @Persisted var cityName: String = ""
    
    @Persisted var latitude: Double = 0
    @Persisted var longitude: Double = 0
}

protocol RealmStoraging {
    func saveLocation(coordinate: CLLocationCoordinate2D)
    func getLocation() -> CLLocationCoordinate2D?
}

class RealmStorage {
    lazy var realm: Realm = {
        try! Realm(configuration: .defaultConfiguration)
    }()
}

extension RealmStorage: RealmStoraging {
    func saveLocation(coordinate: CLLocationCoordinate2D) {
        try? realm.write {
            let locationData = UserLocationData()
            locationData.longitude = coordinate.longitude
            locationData.latitude = coordinate.latitude
            
            realm.add(locationData, update: .all)
        }
    }
    
    func getLocation() -> CLLocationCoordinate2D? {
        guard let userData = realm.objects(UserLocationData.self).first else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: userData.latitude,
                                      longitude: userData.longitude)
    }
}

