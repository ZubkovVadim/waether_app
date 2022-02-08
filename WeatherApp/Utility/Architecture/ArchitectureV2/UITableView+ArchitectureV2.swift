//
//  UITableView+ArchitectureV2.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import UIKit

extension UITableView {
    /// Регистрация массива ячеек с только с уникальными `identifier`
    func register<T: IdentifiableView>(cells: [T.Type]) {
        Set(cells.map { $0.identifier }).compactMap { identifier in
            cells.first(where: { $0.identifier == identifier })
        }
        .forEach(register(cell:))
    }

    /// Супер метод для создания ячееки, и вызова внутри нее метода `configure`
    func dequeueConfigurableCell<T: RowViewModelV2>(
        viewModel: T,
        for indexPath: IndexPath
    ) -> some ConfigurableRow {
        let cell = dequeueReusableCell(viewModel.cellType, for: indexPath)

        if let viewModel = viewModel as? T.Cell.ViewModel {
            cell.configure(viewModel: viewModel)
        }

        return cell
    }
}
