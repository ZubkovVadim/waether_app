//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import UIKit

class OnboardingViewController: BaseViewController {
    private let output: OnboardingViewOutput
    
    init(presenter: OnboardingViewOutput) {
        output = presenter

        super.init()
    }
}

extension OnboardingViewController: OnboardingViewInput {
    
}
