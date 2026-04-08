//
//  LocalJSONLoader.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/10/1447 AH.
//

import Foundation

final class LocalJSONLoader {
    
    static func loadDailyWeather() -> [DailyWeather] {
        guard let url = Bundle.main.url(forResource: "SampleDailyWeather", withExtension: "json") else {
            print("Could not find SampleDailyWeather.json")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let dailyWeather = try JSONDecoder().decode([DailyWeather].self, from: data)
            return dailyWeather
        } catch {
            print("Failed to load daily weather JSON:", error)
            return []
        }
    }
}
