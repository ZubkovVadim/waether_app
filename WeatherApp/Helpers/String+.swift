//
//  String+.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 25.02.2022.
//

import Foundation

extension String {
    func uppercaseFirst() -> String {
        prefix(1).uppercased() + lowercased().dropFirst()
    }
}
