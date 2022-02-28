//
//  DayWeatherCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import UIKit

struct DayWeatherCellViewModel: RowViewModel {
    typealias Cell = DayWeatherCell

    let date: String
    let icon: SkyConditionType
    let rainProbability: Double
    let description: String?
    let minTemp: Double?
    let maxTemp: Double?
}

class DayWeatherCell: BaseTableViewCell {
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightBlue
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = .regular
        view.textColor = .lightTextGray
        view.textAlignment = .center
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()

    private lazy var rainProbabilityImage = UIImageView()
    private lazy var rainProbabilityLabel: UILabel = {
        let view = UILabel()
        view.font = .caption12
        view.textColor = .blueColor
        view.textAlignment = .center
        return view
    }()

    private lazy var rainProbabilityStackView: UIStackView = {
        rainProbabilityImage.contentMode = .scaleAspectFit

        let view = UIStackView(arrangedSubviews: [rainProbabilityImage,
                                                  rainProbabilityLabel])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 4
        return view
    }()

    private lazy var leftStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [dateLabel,
                                                  rainProbabilityStackView])
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 4
        return view
    }()

    private lazy var weatherDescription: UILabel = {
        let view = UILabel()
        view.font = .regular
        view.textColor = .black
        view.textAlignment = .left
        return view
    }()

    private lazy var minMaxTemp: UILabel = {
        let view = UILabel()
        view.font = .subtitleMedium
        view.textColor = .black
        view.textAlignment = .left
        return view
    }()

    override func setupUI() {
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-5)
        }

        background.addSubview(leftStackView)
        leftStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-6)
        }

        background.addSubview(weatherDescription)
        weatherDescription.snp.makeConstraints { make in
            make.centerY.equalTo(background)
            make.left.equalTo(leftStackView.snp.right).offset(10)
        }

        background.addSubview(minMaxTemp)
        minMaxTemp.snp.makeConstraints { make in
            make.centerY.equalTo(background)
            make.left.greaterThanOrEqualTo(weatherDescription.snp.right).offset(4)
            make.right.equalToSuperview().offset(-10)
        }
    }
}

extension DayWeatherCell {
    func configure(viewModel: DayWeatherCellViewModel) {
        dateLabel.text = viewModel.date
        rainProbabilityImage.image = UIImage(named: viewModel.icon.iconName)
        rainProbabilityLabel.text = String(format: "%.0f", viewModel.rainProbability) + " %"

        weatherDescription.text = viewModel.description?.uppercaseFirst()

        if let minTemp = viewModel.minTemp, let maxTemp = viewModel.maxTemp {
            minMaxTemp.text = String(
                format: "%.0f" + .degreesSymbol + "/%.0f" + .degreesSymbol,
                minTemp, maxTemp
            )
        }
    }
}
