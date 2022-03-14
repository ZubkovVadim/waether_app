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

    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(didRequestRefresh), for: .valueChanged)
        return view
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension

        view.refreshControl = refreshControl
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none

        view.register(cell: HeaderMainCell.self)
        view.register(cell: Main24HoursTableCell.self)
        view.register(cell: HeaderDailyLabelCell.self)
        view.register(cell: DayWeatherCell.self)

        return view
    }()

    private var dataSource: [DataType] = [] {
        didSet {
            tableView.reloadData()
            refreshControl.endRefreshing()
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

        refreshControl.beginRefreshing()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.left.top.right.bottom.equalToSuperview() }
    }

    @objc private func didRequestRefresh() {
        presenter.didRequestRefresh()
    }
}

extension MainViewController: MainViewControllerInput {
    func updateTitle(_ title: String?) {
        navigationItem.title = title
    }

    func updateWeather(dataSource: [DataType]) {
        self.dataSource = dataSource
    }

    func showAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))

        present(alert, animated: true)
    }

    func presentOnboardingModule() {
        let module = Assembly.modulesFactory.onboardingModule()
        present(module, animated: true)
    }
    
    func presentHoursDetailModule(hourlyWeather: [HourlyWeatherResponse]) {
        let module = Assembly.modulesFactory.hoursDetailModule(hourlyWeather: hourlyWeather)
        navigationController?.pushViewController(module, animated: true)
    }
    
    func presentDailyWeatherModule(dailyWeathers: [DailyWeatherResponse]) {
        let module = Assembly.modulesFactory.dailyWeatherModule(dailyWeathers: dailyWeathers)
        navigationController?.pushViewController(module, animated: true)
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
        case let .headerDaily(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        case let .dayWeather(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]

        switch model {
        case .header:
            return 244
        case .detail24Hours:
            return 100
        case .headerDaily:
            return 43
        case .dayWeather:
            return 66
        }
    }
}

extension MainViewController {
    enum DataType {
        case header(viewModel: HeaderMainCellViewModel)
        case detail24Hours(viewModel: Main24HoursViewModel)
        case headerDaily(viewModel: HeaderDailyLabelCellViewModel)
        case dayWeather(viewModel: DayWeatherCellViewModel)
    }
}
