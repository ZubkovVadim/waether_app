//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 07.02.2022.
//

import CoreLocation
import Moya

protocol WeatherServing {
    func getCurrentWeather(coordinate: CLLocationCoordinate2D,
                           completion: @escaping (Result<WeatherResponse, Error>) -> Void)
    
    func getDetailHoursWeather(coordinate: CLLocationCoordinate2D,
                               completion: @escaping (Result<HoursResponse, Error>) -> Void)
}

class WeatherService {
    let provider = MoyaProvider<WeatherAPI>()

    init() {}
}

extension WeatherService: WeatherServing {
    func getCurrentWeather(
        coordinate: CLLocationCoordinate2D,
        completion: @escaping (Result<WeatherResponse, Error>) -> Void
    ) {
        let model = BaseWeatherRequest(coordinate: coordinate)
        
        provider.request(.getCurrent(requestModel: model)) { result in
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
    
    func getDetailHoursWeather(
        coordinate: CLLocationCoordinate2D,
        completion: @escaping (Result<HoursResponse, Error>) -> Void
    ) {
        let model = HoursWeatherRequest(count: 24, coordinate: coordinate)
        
        provider.request(.getHours(requestModel: model)) { result in
            switch result {
            case let .success(response):
                do {
                    let weatherDecoder = JSONDecoder()
                    weatherDecoder.dateDecodingStrategy = .secondsSince1970

                    let weatherResponse = try response.map(HoursResponse.self,
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
