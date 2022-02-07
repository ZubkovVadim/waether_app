//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import Moya
import CoreLocation

protocol WeatherServing {
    func getCurrentWeather(coordinate: CLLocationCoordinate2D,
                     completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

class WeatherService {
    let provider = MoyaProvider<WeatherAPI>()
    
    init() {}
}

extension WeatherService: WeatherServing {
    func getCurrentWeather(coordinate: CLLocationCoordinate2D,
                           completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        provider.request(.getCurrent(coordinate: coordinate)) { result in
            switch result {
            case let .success(response):
                do {
                    let weatherDecoder = JSONDecoder()
                    weatherDecoder.dateDecodingStrategy = .secondsSince1970
                    
                    let weatherResponse = try response.map(WeatherResponse.self,
                                                           using: weatherDecoder)
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
