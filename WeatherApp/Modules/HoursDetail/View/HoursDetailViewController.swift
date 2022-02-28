//
//  HoursDetailViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 28.02.2022.
//

import SnapKit
import UIKit

class HoursDetailViewController: BaseViewController {
    private let presenter: HoursDetailViewOutput

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.dataSource = self
        view.separatorStyle = .singleLine
        view.estimatedRowHeight = 150

        view.register(cell: HoursDetailWeatherCell.self)
        return view
    }()
    
    private var dataSource: [DataType] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(presenter: HoursDetailViewOutput) {
        self.presenter = presenter
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        navigationItem.title = "Прогноз на 24 часа"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.left.top.right.bottom.equalToSuperview() }
    }
}

extension HoursDetailViewController: HoursDetailViewInput {
    func updateDataSource(dataSource: [DataType]) {
        self.dataSource = dataSource
    }
}

extension HoursDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]

        switch model {
        case .header:
            return UITableViewCell()

        case let .row(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
}

extension HoursDetailViewController {
    enum DataType {
        case header
        case row(viewModel: HoursDetailWeatherCellViewModel)
    }
}
