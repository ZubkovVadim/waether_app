//
//  OnboardingViewPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 12.01.2022.
//

import Foundation

class OnboardingViewPresenter {
    weak var view: MainViewControllerInput?
    
    init() {}
    
    func getData() {
        // ..
        view?.reload()
    }
}

extension OnboardingViewPresenter: MainViewControllerOutput {
    func tapButton() {
        
    }
}



