//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import SnapKit
import UIKit

class MainViewController: BaseViewController {
    private let presenter: MainViewControllerOutput
    
    private lazy var cityLabel: UILabel = {
       let view = UILabel()
        view.font = .systemFont(ofSize: 20)
        view.textColor = .white
        return view
    }()
    
    private lazy var ellipce: UIImageView = {
        let image = UIImage(named: "main_ellipse")?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .red
        return view
    }()
    
    init(presenter: MainViewControllerOutput) {
        self.presenter = presenter

        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        view.backgroundColor = .purple
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        
        view.addSubview(ellipce)
        ellipce.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

extension MainViewController: MainViewControllerInput {
    func updateWeather(weather: WeatherResponse) {
        cityLabel.text = weather.name
    }
    
    func presentOnboardingModule() {
        let module = Assembly.modulesFactory.onboardingModule()
        present(module, animated: true)
    }
}
