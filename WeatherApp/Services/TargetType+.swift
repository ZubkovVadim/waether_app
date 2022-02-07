//
//  TargetType+.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import Moya

extension TargetType {
    var headers: [String : String]? { nil }
    var validationType: ValidationType { .successAndRedirectCodes }
    var method: Moya.Method { .get }
}
