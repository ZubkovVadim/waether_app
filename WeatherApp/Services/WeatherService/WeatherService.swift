//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import CoreLocation
import Moya

protocol WeatherServing {
    func getWeather(coordinate: CLLocationCoordinate2D,
                    completion: @escaping (Result<MainWeatherResponse, Error>) -> Void)
}

class WeatherService {
    let provider = MoyaProvider<WeatherAPI>()

    init() {}
}

extension WeatherService: WeatherServing {
    func getWeather(
        coordinate: CLLocationCoordinate2D,
        completion: @escaping (Result<MainWeatherResponse, Error>) -> Void
    ) {
        let model = BaseWeatherRequest(coordinate: coordinate)
        
        provider.request(.getWeather(requestModel: model)) { result in
            switch result {
            case let .success(response):
                do {
                    let weatherDecoder = JSONDecoder()
                    weatherDecoder.dateDecodingStrategy = .secondsSince1970

                    let weatherResponse = try response.map(MainWeatherResponse.self, using: weatherDecoder)
                    completion(.success(weatherResponse))
                } catch {
                    completion(.failure(error))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
