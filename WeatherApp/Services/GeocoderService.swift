//
//  GeocoderService.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 24.01.2022.
//

import CoreLocation
import Moya
import QuartzCore

enum Errors: Error {
    case masterRealised
    case nonJsonObject
}

struct GeocoderResponse {
    let cityName: String
}

protocol GeocoderServing {
    func getLocation(coordinate: CLLocationCoordinate2D,
                     completion: @escaping (Result<GeocoderResponse, Error>) -> Void)
}

class GeocoderService {
    let provider = MoyaProvider<GeocoderAPI>()
    
    init() {}
    
    private func mapData(data: Data) throws -> GeocoderResponse {
        let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        
        guard let json = json as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let response = json["response"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let geoObjectCollection = response["GeoObjectCollection"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let featureMember = geoObjectCollection["featureMember"] as? [[String: Any]] else {
            throw Errors.nonJsonObject
        }
        
        guard let geoObject = featureMember.first?["GeoObject"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let metaDataProperty = geoObject["metaDataProperty"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let geocoderMetaData = metaDataProperty["GeocoderMetaData"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let addressDetails = geocoderMetaData["AddressDetails"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let country = addressDetails["Country"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let administrativeArea = country["AdministrativeArea"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let locality = administrativeArea["Locality"] as? [String: Any] else {
            throw Errors.nonJsonObject
        }
        
        guard let localityName = locality["LocalityName"] as? String else {
            throw Errors.nonJsonObject
        }
        
        return GeocoderResponse(cityName: localityName)
    }
}

extension GeocoderService: GeocoderServing {
    func getLocation(coordinate: CLLocationCoordinate2D,
                     completion: @escaping (Result<GeocoderResponse, Error>) -> Void) {
        provider.request(.getLocation(coordinate: coordinate)) { [weak self] result in
            switch result {
            case let .success(response):
                guard let self = self else {
                    completion(.failure(Errors.masterRealised))
                    return
                }
                
                do {
                    let geocoderResponse = try self.mapData(data: response.data)
                    completion(.success(geocoderResponse))

                } catch {
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

enum GeocoderAPI: TargetType {
    case getLocation(coordinate: CLLocationCoordinate2D)

    
    var baseURL: URL {
        URL(string: "https://geocode-maps.yandex.ru/1.x")!
    }
    
    var headers: [String : String]? { nil }
    var validationType: ValidationType { .successAndRedirectCodes }
    var path: String { "" }
    var method: Moya.Method { .get }
    
    var task: Task {
        switch self {
        case let .getLocation(coordinate):
            let format = [coordinate.longitude, coordinate.latitude]
                .map { String(describing: $0) }
                .joined(separator: ",")
            
            return Task.requestParameters(
                parameters: [
                    "format": "json",
                    "apikey": "8a43c9f7-62cf-41d5-9b67-e95598c6b179",
                    "geocode": format
                ],
                encoding: URLEncoding.default
            )
        }
    }
}
