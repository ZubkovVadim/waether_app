//
//  HeaderMainCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import Foundation
import UIKit

class HeaderMainCellViewModel: RowViewModel {
    /// Для поддержки `RowViewModel` можем просто указать какого типа у нас будет ячейка
    typealias Cell = HeaderMainCell

    let cityName: String?
    let action: () -> Void

    init(cityName: String?, action: @escaping () -> Void) {
        self.cityName = cityName
        self.action = action
    }
}

class HeaderMainCell: UITableViewCell {
    // TODO: ADD ANY VIEWS
}

extension HeaderMainCell {
    /// Надо писать в ручную
    /// Можно закрыть протоколом но наверно нет смысла
    func configure(viewModel _: HeaderMainCellViewModel) {
        contentView.backgroundColor = .purple
        // TODO: CONFIGURE CELL
    }
}
