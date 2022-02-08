//
//  HeaderMainCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import Foundation
import UIKit

class HeaderMainCellViewModelV2: RowViewModelV2 {
    /// Для поддержки `RowViewModelV2` можем просто указать какого типа у нас будет ячейка
    typealias Cell = HeaderMainCellV2
    /// ИЛИ
    /// Для поддержки `RowViewModel` надо вернуть тип ячейки
    var cellType: HeaderMainCellV2.Type { HeaderMainCellV2.self }

    let cityName: String?
    let action: () -> Void

    init(cityName: String?, action: @escaping () -> Void) {
        self.cityName = cityName
        self.action = action
    }
}

class HeaderMainCellV2: UITableViewCell {
    // TODO: ADD ANY VIEWS
}

extension HeaderMainCellV2: ConfigurableRow {
    func configure(viewModel _: HeaderMainCellViewModelV2) {
        // TODO: CONFIGURE CELL
        contentView.backgroundColor = .orange
    }
}
