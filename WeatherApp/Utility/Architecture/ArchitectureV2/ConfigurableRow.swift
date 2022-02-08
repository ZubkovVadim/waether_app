//
//  ConfigurableRow.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import UIKit

/// Протокол для каждой ячейки которая хочет,
/// что бы ее настраивала абстрактная `ViewModel` из все
protocol ConfigurableRow: UITableViewCell {
    associatedtype ViewModel: RowViewModelV2

    func configure(viewModel: ViewModel)
}
