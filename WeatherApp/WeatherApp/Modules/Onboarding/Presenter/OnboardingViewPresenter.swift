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
    
    init(
        locationManager: LocationManaging,
        storageService: StorageServing
    ) {
        self.locationManager = locationManager
        self.storageService = storageService
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
        print(location.description)
    }
    
    func didUpdatePermission(status: CLAuthorizationStatus) {
        print(status)
    }
}



