//
//  ModulesFactory.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import Foundation

class ModulesFactory {
    func mainModule() -> MainViewController {
        let presenter = MainViewPresenter()
        let view = MainViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
