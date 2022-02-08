//
//  HeaderMainCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import Foundation
import UIKit
import SnapKit

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

class HeaderMainCell: BaseTableViewCell {
    // TODO: ADD ANY VIEWS
    private lazy var cityLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

extension HeaderMainCell {
    /// Надо писать в ручную
    /// Можно закрыть протоколом но наверно нет смысла
    func configure(viewModel: HeaderMainCellViewModel) {
        contentView.backgroundColor = .purple
        cityLabel.text = viewModel.cityName
        
        // TODO: CONFIGURE CELL
    }
}
