//
//  Fonts.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 20.02.2022.
//

import UIKit

extension UIFont {
    /// "Rubik-Regular", size: 16
    static let regular = UIFont(name: "Rubik-Regular", size: 16) ?? .systemFont(ofSize: 16)

    /// "Rubik-Regular", size: 12
    static let smallRegular = UIFont(name: "Rubik-Regular", size: 12) ?? .systemFont(ofSize: 12)

    /// "Rubik-Medium", size: 36
    static let titleMedium = UIFont(name: "Rubik-Medium", size: 36) ?? .systemFont(ofSize: 36, weight: .medium)

    /// "Rubik-Medium", size: 18
    static let subtitleMedium = UIFont(name: "Rubik-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .medium)

    /// "Rubik-Medium", size: 14
    static let captionMedium = UIFont(name: "Rubik-Medium", size: 14) ?? .systemFont(ofSize: 14, weight: .medium)

    /// "Rubik-Regular", size: 14
    static let caption = UIFont(name: "Rubik-Regular", size: 14) ?? .systemFont(ofSize: 14)

    /// "Rubik-Regular", size: 12
    static let caption12 = UIFont(name: "Rubik-Regular", size: 12) ?? .systemFont(ofSize: 12)
}
