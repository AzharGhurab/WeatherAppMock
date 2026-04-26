//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/09/1447 AH.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
       let main: Main
       let wind: Wind
       let weather: [WeatherCondition]
   }

   struct Main: Decodable {
       let temp: Double
       let humidity: Int
   }

   struct Wind: Decodable {
       let speed: Double
       let deg: Int
   }


struct HourlyWeather {
    let dt: Int
    let temp: Double
    let weather: [WeatherCondition]
}

struct DailyWeather: Decodable {
    let dt: Int
    let rain: Double
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
struct ForecastResponse: Decodable {
    let list: [ForecastItem]
}

struct ForecastItem: Decodable {
    let dt: Int
    let main: ForecastMain
    let weather: [WeatherCondition]
}

struct ForecastMain: Decodable {
    let temp: Double
}
struct DayDetailsModel {
    let date: Date
    let maxTemp: Double
    let minTemp: Double
    let description: String
}

