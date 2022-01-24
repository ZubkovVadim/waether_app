//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation
import UIKit

class MainViewPresenter {
    weak var view: MainViewControllerInput?

    private let realmStorage: RealmStoraging
    private let geocoderService: GeocoderServing
    
    init(
        realmStorage: RealmStoraging,
         geocoderService: GeocoderServing
    ) {
        self.realmStorage = realmStorage
        self.geocoderService = geocoderService
    }
    
    private func getCityName() {
        guard let coordinate = realmStorage.getLocation() else {
            return
        }
        
        geocoderService.getLocation(coordinate: coordinate) { result in
            switch result {
            case let .success(response):
                print("cityName", response.cityName)
                
            case let .failure(error):
                print("error", error)
            }
        }
        
    }
}

extension MainViewPresenter: MainViewControllerOutput {
    func viewDidLoad() {
        getCityName()
    }
}
