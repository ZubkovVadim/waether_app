//
//  DailyWeatherViewContoller.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 14.03.2022.
//

import Foundation
import UIKit
import SnapKit

class DailyWeatherViewContoller: BaseViewController {
    private let presenter: DailyWeatherViewOutput

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.dataSource = self
        view.separatorStyle = .none
        view.estimatedRowHeight = 100

        view.register(cell: DailySelectionTableCell.self)
        view.register(cell: WeatherInformationTableCell.self)
        return view
    }()
    
    private var dataSource: [DataType] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(presenter: DailyWeatherViewOutput) {
        self.presenter = presenter
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        navigationItem.title = "Дневная погода"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.left.top.right.bottom.equalToSuperview() }
    }
}

extension DailyWeatherViewContoller: DailyWeatherViewInput {
    func updateDataSource(dataSource: [DataType]) {
        self.dataSource = dataSource
    }
}

extension DailyWeatherViewContoller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]

        switch model {
        case let .daySelection(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell

        case let .weatherInformation(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
}

extension DailyWeatherViewContoller {
    enum DataType {
        case daySelection(viewModel: DailySelectionTableCellViewModel)
        case weatherInformation(viewModel: WeatherInformationTableCellViewModel)
    }
}
