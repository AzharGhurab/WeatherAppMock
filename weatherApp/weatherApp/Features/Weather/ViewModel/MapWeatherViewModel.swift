//
//  MapWeatherViewModel.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 28/10/1447 AH.
//

import Foundation

final class MapWeatherViewModel {
    
    private let service = WeatherService()
    
    var weather: WeatherResponse?
    
    func fetchWeather(lat: Double,
                      lon: Double,
                      completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        service.fetchWeather(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let data):
                self?.weather = data
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
