//
//  HoursDetailViewInput.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 28.02.2022.
//

import Foundation

protocol HoursDetailViewInput: AnyObject {
    func updateDataSource(dataSource: [HoursDetailViewController.DataType])
}
