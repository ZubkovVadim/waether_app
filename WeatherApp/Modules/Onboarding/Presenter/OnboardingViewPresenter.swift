//
//  OnboardingViewPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 12.01.2022.
//

import CoreLocation

class OnboardingViewPresenter {
    weak var view: OnboardingViewInput?
    
    private let locationManager: LocationManaging
    private let storageService: StorageServing
    private let realmStorage: RealmStoraging
    
    init(
        locationManager: LocationManaging,
        storageService: StorageServing,
        realmStorage: RealmStoraging
    ) {
        self.locationManager = locationManager
        self.storageService = storageService
        self.realmStorage = realmStorage
    }
}

extension OnboardingViewPresenter: OnboardingViewOutput {
    func reqeustLocationButton() {
        locationManager.requestLocationPermission()
        storageService.locationDidRequested()
    }
}

extension OnboardingViewPresenter: LocationManagerOutput {
    func didUpdateLocation(location: CLLocation) {
        realmStorage.saveLocation(coordinate: location.coordinate)
        view?.presentMain()
        print(location.description)
    }
    
    func didUpdatePermission(status: CLAuthorizationStatus) {
        print(status)
    }
}



