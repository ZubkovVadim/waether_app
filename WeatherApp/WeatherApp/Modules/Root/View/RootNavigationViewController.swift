//
//  RootNavigationViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 12.01.2022.
//

import Foundation
import UIKit
import CoreLocation

class RootNavigationViewController: UINavigationController {
    private let presenter: RootNavigationViewOutput
    
    init(presenter: RootNavigationViewOutput) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension RootNavigationViewController: RootNavigationViewInput {
    func startMain() {
        let module = Assembly.modulesFactory.mainModule()
        setViewControllers([module], animated: false)
    }
    
    func startOnboarding() {
        let module = Assembly.modulesFactory.onboardingModule()
        setViewControllers([module], animated: false)
    }
}

protocol RootNavigationViewOutput {
    func viewDidLoad()
}

protocol RootNavigationViewInput: AnyObject {
    func startMain()
    func startOnboarding()
}

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


