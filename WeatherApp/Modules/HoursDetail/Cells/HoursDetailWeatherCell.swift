//
//  HoursDetailWeatherCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 28.02.2022.
//

import UIKit
import SnapKit

struct HoursDetailWeatherCellViewModel: RowViewModel {
    typealias Cell = HoursDetailWeatherCell
    
    let date: String
    let time: String
    let temp: Double
    
    let condition: SkyConditionType
    let description: String?
    let feelTemp: Double
    
    let wind: Double
    let clouds: Double
    let rain: Double
}

class HoursDetailWeatherCell: BaseTableViewCell {
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = .subtitleMedium
        view.textColor = .black
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.font = .caption
        view.textAlignment = .center
        view.textColor = .textGrayColor
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.font = .subtitleMedium
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    private lazy var leftStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [timeLabel, tempLabel])
        view.spacing = 10
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var informationView = createStackView()
    private lazy var windView = createStackView()
    private lazy var rainView = createStackView()
    private lazy var cloudsView = createStackView()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [informationView.stackView,
                                                  windView.stackView,
                                                  rainView.stackView,
                                                  cloudsView.stackView])
        view.spacing = 8
        view.axis = .vertical
        return view
    }()
    
    override func setupUI() {
        contentView.backgroundColor = .lightBlue
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.lessThanOrEqualToSuperview().offset(-16)
        }
        
        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        contentView.addSubview(leftStackView)
        leftStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.right.equalTo(mainStackView.snp.left).offset(-16)
            make.width.equalTo(40)
        }
    }
    
    private func createStackView() -> (icon: UIImageView,
                                       title: UILabel,
                                       info: UILabel,
                                       stackView: UIStackView) {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints { $0.size.equalTo(16) }
        
        let title = UILabel()
        title.font = .caption
        title.textColor = .black
        title.setContentHuggingPriority(.required, for: .horizontal)

        let info = UILabel()
        info.font = .caption
        info.textColor = .textGrayColor
        info.setContentHuggingPriority(.required, for: .horizontal)
        
        let stackView = UIStackView(arrangedSubviews: [icon, title, info])
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return (icon, title, info, stackView)
    }
}

extension HoursDetailWeatherCell {
    func configure(viewModel: HoursDetailWeatherCellViewModel) {
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        tempLabel.text = String(format: "%0.f" + .degreesSymbol, viewModel.temp)
        
        informationView.icon.image = UIImage(named: viewModel.condition.iconName)
        informationView.title.text = viewModel.description?.uppercaseFirst()
        informationView.info.text = String(format: "%0.f" + .degreesSymbol, viewModel.feelTemp)
        
        windView.icon.image = UIImage(named: "wind_icon")
        windView.title.text = "Ветер"
        windView.info.text = String(format: "%0.f", viewModel.wind)
        
        rainView.icon.image = UIImage(named: "humidity_icon")
        rainView.title.text = "Атмосферные осадки"
        rainView.info.text = String(format: "%0.f", viewModel.rain) + "%"
        
        cloudsView.icon.image = UIImage(named: "color_clouds_icon")
        cloudsView.title.text = "Облачность"
        cloudsView.info.text = String(format: "%0.f", viewModel.clouds) + "%"
    }
}
