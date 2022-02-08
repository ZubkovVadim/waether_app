//
//  StorageService.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 12.01.2022.
//

import Foundation

protocol StorageServing {
    func isLocationDidRequest() -> Bool
    func locationDidRequested()
}

class StorageService {
    let defaults = UserDefaults.standard
}

extension StorageService {
    enum Keys: String {
        case locationReqeust
    }
}

extension StorageService: StorageServing {
    func isLocationDidRequest() -> Bool {
        defaults.integer(forKey: Keys.locationReqeust.rawValue) > 0
    }

    func locationDidRequested() {
        defaults.set(1, forKey: Keys.locationReqeust.rawValue)
    }
}
