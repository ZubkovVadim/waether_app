//
//  Assembly.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 12.01.2022.
//

import Foundation

public enum Assembly {
    static var storageService: StorageServing {
        StorageService()
    }
    
    static var modulesFactory: ModulesFactoring {
        ModulesFactory()
    }
}
