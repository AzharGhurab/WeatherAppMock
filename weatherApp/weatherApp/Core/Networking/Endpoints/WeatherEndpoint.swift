//
//  WeatherEndpoint.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/10/1447 AH.
//

import Foundation

enum WeatherEndpoint : EndpointType {
    
    case coordinates(city: String)
    case currentWeather(lat: Double, lon: Double)
    case hourlyForecast(lat: Double, lon: Double)
    
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
    
    var queryParameters: [String: String] {
        switch self {
        case .coordinates(let city):
            return ["q": city, "limit": "1"]
            
        case .currentWeather(let lat, let lon):
            return ["lat": "\(lat)" , "lon": "\(lon)"]
            
        case .hourlyForecast(let lat, let lon):
            return ["lat": "\(lat)" , "lon": "\(lon)"]
        }
    }
                     
    var shouldIncludeMetricUnits: Bool {
        switch self {
        case .coordinates:
            return false
        case .currentWeather, .hourlyForecast:
            return true
        }
    }
                     
        var httpMethod: HTTPMethod {
            switch self {
            case .coordinates, .currentWeather, .hourlyForecast:
                return .get
            }
        }
    }

