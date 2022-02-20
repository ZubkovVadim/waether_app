//
//  DateFormatter+.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 20.02.2022.
//

import Foundation

extension DateFormatter {
    static func string(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
