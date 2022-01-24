//
//  RootNavigationViewPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 24.01.2022.
//

import CoreLocation

class RootNavigationViewPresenter {
    weak var view: RootNavigationViewInput?
    
    private let storageService: StorageServing
    
    init(storageService: StorageServing) {
        self.storageService = storageService
    }
}

extension RootNavigationViewPresenter: RootNavigationViewOutput {
    func viewDidLoad() {
        if storageService.isLocationDidRequest() {
            view?.startMain()
        } else {
            view?.startOnboarding()
        }
    }
}

extension RootNavigationViewPresenter: LocationManagerOutput {
    func didUpdateLocation(location: CLLocation) {}
    func didUpdatePermission(status: CLAuthorizationStatus) {}
}
