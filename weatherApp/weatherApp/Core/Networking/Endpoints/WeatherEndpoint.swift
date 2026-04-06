//
//  WeatherEndpoint.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/10/1447 AH.
//

import Foundation

enum WeatherEndpoint {
    
    case coordinates(city: String, apiKey: String)
    case currentWeather(lat: Double, lon: Double, apiKey: String)
    case hourlyForecast(lat: Double, lon: Double, apiKey: String)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        
        switch self {
            
        case .coordinates(let city, let apiKey):
            components.path = "/geo/1.0/direct"
            components.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "limit", value: "1"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
            
        case .currentWeather(let lat, let lon, let apiKey):
            components.path = "/data/2.5/weather"
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
            
        case .hourlyForecast(let lat, let lon, let apiKey):
            components.path = "/data/2.5/forecast"
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
        }
        
        return components.url
    }
}
