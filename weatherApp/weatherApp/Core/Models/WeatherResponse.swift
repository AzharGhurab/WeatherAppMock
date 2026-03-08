//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/09/1447 AH.
//

import Foundation

struct WeatherResponse: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather: Decodable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [WeatherCondition]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

struct HourlyWeather: Decodable {
    let dt: Int
    let temp: Double
    let weather: [WeatherCondition]
}

struct DailyWeather: Decodable {
    let dt: Int
    let temp: Temperature
    let weather: [WeatherCondition]
}

struct Temperature: Decodable {
    let min: Double
    let max: Double
}

struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
