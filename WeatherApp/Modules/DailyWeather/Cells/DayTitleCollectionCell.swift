//
//  DayTitleCollectionCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 14.03.2022.
//

import Foundation
import UIKit
import SnapKit

struct DayTitleCollectionCellViewModel: RowViewModel {
    typealias Cell = DayTitleCollectionCell

    let date: String
}

class DayTitleCollectionCell: UICollectionViewCell {
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = .titleRegular
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            dateLabel.textColor = isSelected ? .white : .black
            contentView.backgroundColor = isSelected ? .blueColor : .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(6)
            make.right.bottom.equalToSuperview().offset(-6)
        }
    }
}

extension DayTitleCollectionCell {
    func configure(viewModel: DayTitleCollectionCellViewModel) {
        dateLabel.text = viewModel.date
    }
}
