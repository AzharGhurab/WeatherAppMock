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
    
    var path: String {
        switch self {
        case .coordinates:
            return "/geo/1.0/direct"
        case .currentWeather:
            return "/data/2.5/weather"
        case .hourlyForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .coordinates(let city, let apiKey):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "limit", value: "1"),
                URLQueryItem(name: "appid", value: apiKey)
            ]
            
        case .currentWeather(let lat, let lon, let apiKey):
            return [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
            
        case .hourlyForecast(let lat, let lon, let apiKey):
            return [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
        }
    }
        var httpMethod: HTTPMethod {
            switch self {
            case .coordinates, .currentWeather, .hourlyForecast:
                return .get
            }
        }
    }

