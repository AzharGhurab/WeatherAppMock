//
//   WeatherService.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/09/1447 AH.
//

import Foundation

class WeatherService {
    
    
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found")
        }
        return key
    }
    private func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(
                    domain: "WeatherService",
                    code: 500,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid server response"]
                )
                completion(.failure(error))
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                let error = NSError(
                    domain: "WeatherService",
                    code: httpResponse.statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "Server error: \(httpResponse.statusCode)"]
                )
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(
                    domain: "WeatherService",
                    code: 500,
                    userInfo: [NSLocalizedDescriptionKey: "No data returned"]
                )
                completion(.failure(error))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchCoordinates(for city: String,
                          completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        
        guard let url = WeatherEndpoint.coordinates(city: city, apiKey: apiKey).url else {
            let urlError = NSError(
                domain: "WeatherService",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Invalid coordinates URL"]
            )
            completion(.failure(urlError))
            return
        }
        
        request(url: url) { (result: Result<[GeoResponse], Error>) in
            switch result {
            case .success(let locations):
                guard let first = locations.first else {
                    let error = NSError(
                        domain: "WeatherService",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: "City not found"]
                    )
                    completion(.failure(error))
                    return
                }
                completion(.success((first.lat, first.lon)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchWeather(lat: Double,
                      lon: Double,
                      completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        guard let url = WeatherEndpoint.currentWeather(lat: lat, lon: lon, apiKey: apiKey).url else {
            let urlError = NSError(
                domain: "WeatherService",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Invalid weather URL"]
            )
            completion(.failure(urlError))
            return
        }
        request(url: url, completion: completion)
    }
    
    func fetchHourlyForecast(lat: Double,
                             lon: Double,
                             completion: @escaping (Result<[HourlyWeather], Error>) -> Void) {
        
        guard let url = WeatherEndpoint.hourlyForecast(lat: lat, lon: lon, apiKey: apiKey).url  else {
            let error = NSError(
                domain: "WeatherService",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Invalid hourly forecast URL"]
            )
            completion(.failure(error))
            return
        }
        
        request(url: url) { (result: Result<ForecastResponse, Error>) in
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
