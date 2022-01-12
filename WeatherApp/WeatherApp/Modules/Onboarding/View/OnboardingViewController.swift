//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import UIKit

class OnboardingViewController: BaseViewController {
    private let presenter: OnboardingViewOutput
    
    private lazy var requestLocation: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor.orange.withAlphaComponent(0.9)
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        view.setTitle("Использовать геопозицию", for: .normal)
        view.frame.size = CGSize(width: 200, height: 100)
        return view
    }()
    
    init(presenter: OnboardingViewOutput) {
        self.presenter = presenter

        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(requestLocation)

        requestLocation.center = view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc private func tapButton() {
        presenter.reqeustLocationButton()
    }
}

extension OnboardingViewController: OnboardingViewInput {
    
}
