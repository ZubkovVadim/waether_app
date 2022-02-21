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
    
    let minDegrees, maxDegrees, currentDegrees: String
    let weatherDescription: String?
    
    let sunsetTime, sunriseTime: String
    let cloudValue, windValue, humidityValue: String
    
    let todayValue: String
    
    init(
        minDegrees: String,
        maxDegrees: String,
        currentDegrees: String,
        weatherDescription: String?,
        sunsetTime: String,
        sunriseTime: String,
        cloudValue: String,
        windValue: String,
        humidityValue: String,
        todayValue: String
    ) {
        self.minDegrees = minDegrees
        self.maxDegrees = maxDegrees
        self.currentDegrees = currentDegrees
        self.weatherDescription = weatherDescription
        self.sunsetTime = sunsetTime
        self.sunriseTime = sunriseTime
        self.cloudValue = cloudValue
        self.windValue = windValue
        self.humidityValue = humidityValue
        self.todayValue = todayValue
    }
}

class HeaderMainCell: BaseTableViewCell {
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .blueColor
        return view
    }()
    
    private lazy var sunlineView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "main_ellipse"))
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topStackView, bottomStackView, todayLabel])
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()

    private lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [minMaxDegrees, currentDegrees, weatherDescription])
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 5
        return view
    }()
    
    private lazy var minMaxDegrees: UILabel = {
        let view = UILabel()
        view.font = .regular
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    
    private lazy var currentDegrees: UILabel = {
        let view = UILabel()
        view.font = .titleMedium
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    private lazy var weatherDescription: UILabel = {
        let view = UILabel()
        view.font = .regular
        view.textAlignment = .center
        view.textColor = .white
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let view = UILabel()
        view.font = .captionMedium
        view.textColor = .white
        return view
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let view = UILabel()
        view.font = .captionMedium
        view.textColor = .white
        return view
    }()
    
    private lazy var sunriseStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "sunrise_icon"))
        image.contentMode = .scaleAspectFit
        
        let view = UIStackView(arrangedSubviews: [image, sunriseLabel])
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 4
        return view
    }()
    
    private lazy var sunsetStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "sunset_icon"))
        image.contentMode = .scaleAspectFit
        
        let view = UIStackView(arrangedSubviews: [image, sunsetLabel])
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 4
        return view
    }()
    
    private lazy var cloudsLabel: UILabel = {
        let view = UILabel()
        view.font = .caption
        view.textColor = .white
        return view
    }()
    
    private lazy var cloudsStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "clouds_icon"))
        image.contentMode = .scaleAspectFit
        
        let view = UIStackView(arrangedSubviews: [image, cloudsLabel])
        view.axis = .horizontal
        view.spacing = 2
        return view
    }()
    
    private lazy var windLabel: UILabel = {
        let view = UILabel()
        view.font = .caption
        view.textColor = .white
        return view
    }()
    
    private lazy var windStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "wind_icon"))
        image.contentMode = .scaleAspectFit
        
        let view = UIStackView(arrangedSubviews: [image, windLabel])
        view.axis = .horizontal
        view.spacing = 2
        return view
    }()
    
    
    private lazy var humidityLabel: UILabel = {
        let view = UILabel()
        view.font = .caption
        view.textColor = .white
        return view
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let image = UIImageView(image: UIImage(named: "humidity_icon"))
        image.contentMode = .scaleAspectFit
        
        let view = UIStackView(arrangedSubviews: [image, humidityLabel])
        view.axis = .horizontal
        view.spacing = 2
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cloudsStackView, windStackView, humidityStackView])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 16
        
        view.snp.makeConstraints { $0.height.equalTo(18) }
        
        return view
    }()
    
    private lazy var todayLabel: UILabel = {
        let view = UILabel()
        view.font = .regular
        view.textColor = .yellowColor
        view.textAlignment = .center
        return view
    }()
    
    override func setupUI() {
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().offset(-16)
        }
        
        background.addSubview(sunlineView)
        sunlineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        background.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(sunlineView).offset(16)
        }
        
        background.addSubview(sunriseStackView)
        sunriseStackView.snp.makeConstraints { make in
            make.top.equalTo(sunlineView.snp.bottom).offset(4)
            make.centerX.equalTo(sunlineView.snp.left).offset(2)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-26)
        }
        
        background.addSubview(sunsetStackView)
        sunsetStackView.snp.makeConstraints { make in
            make.top.equalTo(sunlineView.snp.bottom).offset(4)
            make.centerX.equalTo(sunlineView.snp.right).offset(-2)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-26)
        }
    }
}

extension HeaderMainCell {
    func configure(viewModel: HeaderMainCellViewModel) {
        minMaxDegrees.text = [
            viewModel.minDegrees,
            String.degreesSymbol,
            "/",
            viewModel.maxDegrees,
            String.degreesSymbol
        ].joined()
        
        currentDegrees.text = viewModel.currentDegrees + String.degreesSymbol
        weatherDescription.text = viewModel.weatherDescription
        
        sunriseLabel.text = viewModel.sunriseTime
        sunsetLabel.text = viewModel.sunsetTime
        
        cloudsLabel.text = viewModel.cloudValue
        windLabel.text = viewModel.windValue + "м/с"
        humidityLabel.text = viewModel.humidityValue + "%"
        todayLabel.text = viewModel.todayValue
    }
}
