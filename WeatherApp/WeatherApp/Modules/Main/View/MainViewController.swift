//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    private let output: MainViewControllerOutput
    
    init(presenter: MainViewControllerOutput) {
        output = presenter

        super.init()
    }
}

extension MainViewController: MainViewControllerInput {
    func reload() {
        // reload table
    }
}
