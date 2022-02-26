//
//  HeaderDailyLabelCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import UIKit

class HeaderDailyLabelCellViewModel: RowViewModel {
    typealias Cell = HeaderDailyLabelCell

    let detailButtonAction: () -> Void

    init(detailButtonAction: @escaping () -> Void = {}) {
        self.detailButtonAction = detailButtonAction
    }
}

class HeaderDailyLabelCell: BaseTableViewCell {
    @objc private var detailButtonAction: () -> Void = {}

    private lazy var header: UILabel = {
        let view = UILabel()
        view.font = .subtitleMedium
        view.textColor = .black
        view.text = "Ежедневный прогноз"
        return view
    }()

    private lazy var detailButton: UIButton = {
        let view = UIButton(type: .system)

        let attributedText = NSMutableAttributedString(
            string: "7 дней",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                         .font: UIFont.regular,
                         .foregroundColor: UIColor.black]
        )

        view.setAttributedTitle(attributedText, for: .normal)
        view.addTarget(self, action: #selector(detailButtonTap), for: .touchUpInside)
        return view
    }()

    override func setupUI() {
        contentView.addSubview(header)
        header.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-5)
        }

        contentView.addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.centerY.equalTo(header)
            make.right.equalToSuperview().offset(-16)
            make.left.greaterThanOrEqualTo(header.snp.right)
        }
    }

    @objc private func detailButtonTap() {
        detailButtonAction()
    }
}

extension HeaderDailyLabelCell {
    func configure(viewModel: HeaderDailyLabelCellViewModel) {
        detailButtonAction = viewModel.detailButtonAction
    }
}
