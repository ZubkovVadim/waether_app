//
//  WeatherInformationTableCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 14.03.2022.
//

import Foundation
import UIKit
import SnapKit

struct WeatherInformationTableCellViewModel: RowViewModel {
    typealias Cell = WeatherInformationTableCell
    
    let timeOfDay: String
    let skyConditionType: SkyConditionType
    let temp: Double
    let weatherDescription: String
    
    let feelTemp: Double
    let uvIndex: Double
    let wind: Double
    let clouds: Double
    let rain: Double
}

class WeatherInformationTableCell: BaseTableViewCell {
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightBlue
        return view
    }()
    
    private lazy var timeOfDayLabel: UILabel = {
        let view = UILabel()
        view.font = .titleRegular
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.font = .bigRegular
        view.textAlignment = .center
        return view
    }()
    
    private lazy var tempStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [iconImage, tempLabel])
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var weatherDescription: UILabel = {
        let view = UILabel()
        view.font = .titleRegular
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    private lazy var separatorBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorBlue
        return view
    }()
    
    private lazy var tempInformationView = createStackView()
    private lazy var windView = createStackView()
    private lazy var ufIndexView = createStackView()
    private lazy var rainView = createStackView()
    private lazy var cloudsView = createStackView()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [tempInformationView.view,
                                                  windView.view,
                                                  ufIndexView.view,
                                                  rainView.view,
                                                  cloudsView.view])
        view.spacing = 0.5
        view.axis = .vertical
        return view
    }()
    
    override func setupUI() {
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        background.addSubview(tempStackView)
        tempStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        background.addSubview(timeOfDayLabel)
        timeOfDayLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalTo(tempStackView)
        }
        
        background.addSubview(weatherDescription)
        weatherDescription.snp.makeConstraints { make in
            make.top.equalTo(tempStackView.snp.bottom).offset(10)
            make.centerX.equalTo(tempStackView)
        }
        
        background.addSubview(separatorBackground)
        separatorBackground.snp.makeConstraints { make in
            make.top.equalTo(weatherDescription.snp.bottom).offset(25)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
        
        background.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(separatorBackground)
            make.left.right.equalTo(separatorBackground)
            make.bottom.equalTo(separatorBackground).offset(-0.5)
        }
    }
    
    private func createStackView() -> (icon: UIImageView,
                                       title: UILabel,
                                       info: UILabel,
                                       view: UIView) {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints { $0.size.equalTo(26) }
        
        let title = UILabel()
        title.font = .caption
        title.textColor = .black
        title.setContentHuggingPriority(.required, for: .horizontal)

        let info = UILabel()
        info.font = .titleRegular
        info.textColor = .black
        info.setContentHuggingPriority(.required, for: .horizontal)
        
        let stackView = UIStackView(arrangedSubviews: [icon, title, info])
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let view = UIView()
        view.backgroundColor = .lightBlue
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        return (icon, title, info, view)
    }
}

extension WeatherInformationTableCell {
    func configure(viewModel: WeatherInformationTableCellViewModel) {
        timeOfDayLabel.text = viewModel.timeOfDay
        tempLabel.text = String(format: "%0.f" + .degreesSymbol, viewModel.temp)
        iconImage.image = UIImage(named: viewModel.skyConditionType.iconName)
        
        weatherDescription.text = viewModel.weatherDescription.uppercaseFirst()
        
        tempInformationView.icon.image = UIImage(named: "feellike_icon")
        tempInformationView.title.text = "По ощущениям"
        tempInformationView.info.text = String(format: "%0.f", viewModel.feelTemp)
        
        windView.icon.image = UIImage(named: "wind_icon")
        windView.title.text = "Ветер"
        windView.info.text = String(format: "%0.f", viewModel.wind)
        
        ufIndexView.icon.image = UIImage(named: "uvi_icon")
        ufIndexView.title.text = "Уф индекс"
        ufIndexView.info.text = String(format: "%0.f", viewModel.uvIndex)
        
        rainView.icon.image = UIImage(named: "humidity_icon")
        rainView.title.text = "Дождь"
        rainView.info.text = String(format: "%0.f", viewModel.rain) + "%"
        
        cloudsView.icon.image = UIImage(named: "color_clouds_icon")
        cloudsView.title.text = "Облачность"
        cloudsView.info.text = String(format: "%0.f", viewModel.clouds) + "%"
    }
}
