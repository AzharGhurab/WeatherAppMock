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
    
    func fetchCoordinates(for city: String,
                          completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(encodedCity)&limit=1&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            let urlError = NSError(
                domain: "WeatherService",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Invalid coordinates URL"]
            )
            completion(.failure(urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                
                let noDataError = NSError(
                    domain: "WeatherService",
                    code: 500,
                    userInfo: [NSLocalizedDescriptionKey: "No data returned for coordinates request"]
                )
                completion(.failure(noDataError))
                return
            }
            do {
                let result = try JSONDecoder().decode([GeoResponse].self, from: data)
                
                guard let first = result.first else {
                    let notFoundError = NSError(
                        domain: "WeatherService",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: "City not found"]
                    )
                    completion(.failure(notFoundError))
                    return
                }
                
                completion(.success((first.lat, first.lon)))
                
            } catch {
                
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchWeather(lat: Double,
                      lon: Double,
                      completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            let urlError = NSError(
                domain: "WeatherService",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Invalid weather URL"]
            )
            completion(.failure(urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(
                    domain: "WeatherService",
                    code: 500,
                    userInfo: [NSLocalizedDescriptionKey: "No data returned for weather request"]
                )
                completion(.failure(noDataError))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchHourlyForecast(lat: Double,
                             lon: Double,
                             completion: @escaping (Result<[HourlyWeather], Error>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            let error = NSError(
                domain: "WeatherService",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Invalid hourly forecast URL"]
            )
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(
                    domain: "WeatherService",
                    code: 500,
                    userInfo: [NSLocalizedDescriptionKey: "No data returned for hourly forecast request"]
                )
                completion(.failure(error))
                return
            }
            
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                
                let hourlyItems = forecastResponse.list.prefix(8).map {
                    HourlyWeather(
                        dt: $0.dt,
                        temp: $0.main.temp,
                        weather: $0.weather
                    )
                }
                
                completion(.success(Array(hourlyItems)))
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}

