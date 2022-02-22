//
//  UITableView+Architecture.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import UIKit

extension UITableView {
    /// Регистрация ячейки по с уникальному `identifier`
    func register<T: IdentifiableView>(cell: T.Type) {
        register(cell.self, forCellReuseIdentifier: cell.identifier)
    }

    /// Ячейка по `identifier`, который был зарегитсрирован
    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: IdentifiableView {
        dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
}


extension UICollectionView {
    /// Регистрация ячейки по с уникальному `identifier`
    func register<T: IdentifiableView>(cell: T.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }

    /// Ячейка по `identifier`, который был зарегитсрирован
    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: IdentifiableView {
        dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
    }
}
