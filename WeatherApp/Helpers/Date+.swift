//
//  Date+.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 20.02.2022.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
