//
//  GeocoderService.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 24.01.2022.
//

import CoreLocation
import Moya
import QuartzCore

protocol GeocoderServing {
    func getLocation(coordinate: CLLocationCoordinate2D,
                     completion: @escaping (Result<GeocoderResponse, Error>) -> Void)
}

class GeocoderService {
    let provider = MoyaProvider<GeocoderAPI>()

    init() {}
}

extension GeocoderService: GeocoderServing {
    func getLocation(coordinate: CLLocationCoordinate2D,
                     completion: @escaping (Result<GeocoderResponse, Error>) -> Void)
    {
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

extension GeocoderService {
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
