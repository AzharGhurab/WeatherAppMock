//
//   WeatherService.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/09/1447 AH.
//

import Foundation

final class WeatherService {
    
    private var apiKey: String { NetworkManager.apiKey }
    
    func fetchCoordinates(
        for city: String,
        completion: @escaping (Result<(Double, Double), Error>) -> Void
    ) {
        guard let request = URLRequest(
            weatherEndpoint: .coordinates(city: city, apiKey: apiKey)
        ) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        NetworkManager.request(request: request) { (result: Result<[GeoResponse], Error>) in
            switch result {
            case .success(let locations):
                guard let first = locations.first else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                completion(.success((first.lat, first.lon)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchWeather(
        lat: Double,
        lon: Double,
        completion: @escaping (Result<WeatherResponse, Error>) -> Void
    ) {
        guard let request = URLRequest(
            weatherEndpoint: .currentWeather(lat: lat, lon: lon, apiKey: apiKey)
        ) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        NetworkManager.request(request: request, completion: completion)
    }
    
    func fetchHourlyForecast(
        lat: Double,
        lon: Double,
        completion: @escaping (Result<[HourlyWeather], Error>) -> Void
    ) {
        guard let request = URLRequest(
            weatherEndpoint: .hourlyForecast(lat: lat, lon: lon, apiKey: apiKey)
        ) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        NetworkManager.request(request: request) { (result: Result<ForecastResponse, Error>) in
            switch result {
            case .success(let forecastResponse):
                let hourlyItems = forecastResponse.list.prefix(8).map {
                    HourlyWeather(
                        dt: $0.dt,
                        temp: $0.main.temp,
                        weather: $0.weather
                    )
                }
                completion(.success(Array(hourlyItems)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
