//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 11.01.2022.
//

import SnapKit
import UIKit

// Presenter получить данные
// Presenter сформировать dataSource == массив ViewModels
// Presenter отдать контроллеру dataSource
// ViewController отдает dataSource -> TableView
// TableView -> созадет ячейку с типом из ViewModel
// TableView -> конфигурирует ячейку c данными из ViewModel

class MainViewController: BaseViewController {
    private let presenter: MainViewControllerOutput

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        
        view.register(cell: HeaderMainCell.self)
        view.register(cell: Main24HoursTableCell.self)
        return view
    }()

    private var dataSource: [DataType] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    init(presenter: MainViewControllerOutput) {
        self.presenter = presenter

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.left.top.right.bottom.equalToSuperview() }
    }
}

extension MainViewController: MainViewControllerInput {
    func updateTitle(_ title: String?) {
        navigationItem.title = title
    }
    
    func updateWeather(dataSource: [DataType]) {
        self.dataSource = dataSource
    }

    func presentOnboardingModule() {
        let module = Assembly.modulesFactory.onboardingModule()
        present(module, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]

        switch model {
        case let .header(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .detail24Hours(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]
        
        switch model {
        case .header:
            return 244
        case .detail24Hours:
            return 100
        }
    }
}

extension MainViewController {
    enum DataType {
        case header(viewModel: HeaderMainCellViewModel)
        case detail24Hours(viewModel: Main24HoursViewModel)
    }
}
