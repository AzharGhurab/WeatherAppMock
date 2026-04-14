//
//   WeatherService.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/09/1447 AH.
//

import Foundation

final class WeatherService {
    
    private let requestBuilder = WeatherRequestBuilder(apiKey: NetworkManager.apiKey)
    func fetchCoordinates(
        for city: String,
        completion: @escaping (Result<(Double, Double), Error>) -> Void
    ) {
        let apiRequest = WeatherEndpoint.coordinates(city: city)
        guard let request = requestBuilder.makeRequest(
            for: apiRequest
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
        let apiRequest = WeatherEndpoint.currentWeather(lat: lat, lon: lon)
        guard let request = requestBuilder.makeRequest(
            for: apiRequest
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
        let apiRequest = WeatherEndpoint.hourlyForecast(lat: lat, lon: lon)
              guard let request = requestBuilder.makeRequest(
                for: apiRequest 
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
