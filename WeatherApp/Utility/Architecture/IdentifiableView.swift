//
//  IdentifiableView.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 08.02.2022.
//

import UIKit

/// Протокол который нужно подержать каждой ячейке что бы работать с ней по названию ее класса
protocol IdentifiableView: AnyObject {
    static var identifier: String { get }
}

/// Разширение для стандартоного `UITableViewCell`
extension UITableViewCell: IdentifiableView {
    static var identifier: String {
        String(describing: self)
    }
}

/// Разширение для стандартоного `UICollectionViewCell`
extension UICollectionViewCell: IdentifiableView {
    static var identifier: String {
        String(describing: self)
    }
}
