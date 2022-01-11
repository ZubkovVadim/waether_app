//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation

class MainViewPresenter {
    weak var view: MainViewControllerInput?
    
    init() {}
    
    func getData() {
        // ..
        view?.reload()
    }
}

extension MainViewPresenter: MainViewControllerOutput {
    func tapButton() {
        
    }
}
