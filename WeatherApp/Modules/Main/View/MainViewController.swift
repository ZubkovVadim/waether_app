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
        

        /// Можно использовать, наверно даже лучше, регистрировать их один раз
        view.register(cell: HeaderMainCell.self)
//        view.register(cell: HeaderMainCellV2.self)

        return view
    }()

    private var dataSource: [DataType] = [] {
        didSet {
            /// Можно использовать хак с перегистрацией всех ячеек при изменении dataSource
//            tableView.register(cells: dataSource.map { $0.identifier })
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
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]
        
        switch model {
        case .header:
            return 244
        }
    }
}

extension MainViewController {
    enum DataType {
        case header(viewModel: HeaderMainCellViewModel)
    }
}
