//
//  Task+.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 23.02.2022.
//

import Foundation
import Moya

extension Task {
    static func requestParameters<T: Encodable>(
        encodable: T,
        encoder: JSONEncoder = JSONEncoder(),
        parameterEncoding: ParameterEncoding = URLEncoding.default
    ) -> Task {
        var parameters: [String: Any] = [:]

        do {
            let data = try encoder.encode(encodable)
            let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)

            parameters = json as? [String: Any] ?? [:]

        } catch {
            assertionFailure(error.localizedDescription)
        }

        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}
