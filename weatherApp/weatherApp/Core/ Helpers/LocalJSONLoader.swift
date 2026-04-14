//
//  LocalJSONLoader.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/10/1447 AH.
//

import Foundation

final class LocalJSONLoader {
    
    static func loadDailyWeather()-> Result<[DailyWeather], Error>  {
        
        guard let url = Bundle.main.url(forResource: "SampleDailyWeather", withExtension: "json") else {
            print("Could not find SampleDailyWeather.json")
            return.failure(NSError(
                domain: "LocalJSONLoader",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "Could not find SampleDailyWeather.json"]
            ))
        }
        
        do {
            let data = try Data(contentsOf: url)
            let dailyWeather = try JSONDecoder().decode([DailyWeather].self, from: data)
            return .success(dailyWeather)
        } catch {
            return . failure(error)
        }
    }
}
