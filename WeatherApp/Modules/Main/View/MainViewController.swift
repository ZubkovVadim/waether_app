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

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self

        /// Можно использовать, наверно даже лучше, регитрировать их один раз
        view.register(cell: HeaderMainCell.self)
        view.register(cell: HeaderMainCellV2.self)

        return view
    }()

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

    private var dataSource: [DataType] = [] {
        didSet {
            /// Можно использовать хак с перегистрацией всех ячеек при изменении dataSource
            tableView.register(cells: dataSource.map { $0.identifier })
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

        view.backgroundColor = .purple
        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.left.top.right.bottom.equalToSuperview() }

        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { $0.center.equalToSuperview() }

        view.addSubview(ellipce)
        ellipce.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

extension MainViewController: MainViewControllerInput {
    func updateWeather(weather: WeatherResponse) {
        cityLabel.text = weather.name
        let model = HeaderMainCellViewModel(cityName: "Moscow", action: {})
        let modelV2 = HeaderMainCellViewModelV2(cityName: "MoscowV2", action: {})
        dataSource = [.main(viewModel: model)]

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dataSource = [.main(viewModel: model), .mainV2(viewModel: modelV2)]
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataSource = [.main(viewModel: model)]
        }
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
        case let .main(viewModel):
            let cell = tableView.dequeueReusableCell(viewModel.cellType, for: indexPath)
            cell.configure(viewModel: viewModel)

            return cell

        case let .mainV2(viewModel):
            return tableView.dequeueConfigurableCell(viewModel: viewModel, for: indexPath)
        }
    }
}

extension MainViewController {
    enum DataType {
        case main(viewModel: HeaderMainCellViewModel)
        case mainV2(viewModel: HeaderMainCellViewModelV2)

        var identifier: IdentifiableView.Type {
            switch self {
            case let .main(row):
                return row.cellType
            case let .mainV2(row):
                return row.cellType
            }
        }
    }
}
