//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/09/1447 AH.
//

import Foundation

class WeatherViewModel {
    
    private let service = WeatherService()
    
    var weather: WeatherResponse?
    var hourlyForecast: [HourlyWeather] = []
    
    func loadWeather(for city: String,
                     completion: @escaping (Result<Void, Error>) -> Void) {
        service.fetchCoordinates(for: city) { [weak self] result in
            switch result {
            case .success(let coordinates):
                
                let (lat, lon) = coordinates
                let group = DispatchGroup()
                var capturedError: Error?
                
                group.enter()
                self?.service.fetchWeather(lat: lat, lon: lon) { result in
                    switch result {
                    case .success(let data):
                        self?.weather = data
                    case .failure(let error):
                        capturedError = error
                    }
                    group.leave()
                }
                
                group.enter()
                self?.service.fetchHourlyForecast(lat: lat, lon: lon) { result in
                    switch result {
                    case .success(let forecastResponse):
                        self?.hourlyForecast = forecastResponse.list.prefix(8).map {
                            HourlyWeather(
                                dt: $0.dt,
                                temp: $0.main.temp,
                                weather: $0.weather
                            )
                        }
                    case .failure(let error):
                        capturedError = error
                    }
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    if let error = capturedError {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
