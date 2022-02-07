//
//  Assembly.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 12.01.2022.
//

import Foundation

public enum Assembly {
    static var weatherService: WeatherServing {
        WeatherService()
    }
    
    static var storageService: StorageServing {
        StorageService()
    }
    
    static var realmStorage: RealmStoraging {
        RealmStorage()
    }
    
    static var geocoderService: GeocoderServing {
        GeocoderService()
    }
    
    static var modulesFactory: ModulesFactoring {
        ModulesFactory()
    }
}
