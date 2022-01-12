//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    private let presenter: MainViewControllerOutput
    
    init(presenter: MainViewControllerOutput) {
        self.presenter = presenter

        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

extension MainViewController: MainViewControllerInput {
    func presentOnboardingModule() {
        let module = Assembly.modulesFactory.onboardingModule()
        present(module, animated: true)
    }
}
