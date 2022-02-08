//
//  RowViewModelV2.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import Foundation

protocol RowViewModelV2 {
    associatedtype Cell: ConfigurableRow

    var cellType: Cell.Type { get }
}

/// Разширение для `RowViewModelV2` что бы в модели можно было только проставить `typealias Cell`
/// А проперти отработает сама
extension RowViewModelV2 {
    var cellType: Cell.Type { Cell.self }
}
