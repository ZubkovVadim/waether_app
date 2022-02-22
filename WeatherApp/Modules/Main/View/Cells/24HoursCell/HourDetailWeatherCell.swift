//
//  HourDetailWeatherCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 21.02.2022.
//

import Foundation
import UIKit

struct HourDetailWeatherCellViewModel: RowViewModel {
    typealias Cell = HourDetailWeatherCell
    
    let time: String
    let skyConditionType: SkyConditionType
    let temp: String
    
    init(time: String, skyConditionType: HourDetailWeatherCellViewModel.SkyConditionType, temp: String) {
        self.time = time
        self.skyConditionType = skyConditionType
        self.temp = temp
    }
}

extension HourDetailWeatherCellViewModel {
    enum SkyConditionType {
        case clear, clouds, rain
    }
}

class HourDetailWeatherCell: UICollectionViewCell {
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.borderGrayColor.cgColor
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.font = .smallRegular
        view.textAlignment = .center
        view.textColor = .textGrayColor
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
        let view = UILabel()
        view.font = .regular
        view.textAlignment = .center
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [timeLabel, iconImage, tempLabel])
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillProportionally
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        mainView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

extension HourDetailWeatherCell {
    func configure(viewModel: HourDetailWeatherCellViewModel) {
        timeLabel.text = viewModel.time
        iconImage.image = UIImage(named: "sun_icon")
        tempLabel.text = viewModel.temp + .degreesSymbol
    }
}

