//
//  RowViewModel.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import UIKit

protocol RowViewModel {
    associatedtype Cell: IdentifiableView

    var cellType: Cell.Type { get }
}

/// Разширение для `RowViewModel` что бы в модели можно было только проставить `typealias Cell`
/// А проперти отработает сама
extension RowViewModel {
    var cellType: Cell.Type { Cell.self }
}
