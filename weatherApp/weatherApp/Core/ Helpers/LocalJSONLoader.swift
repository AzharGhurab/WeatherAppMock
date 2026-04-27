//
//  LocalJSONLoader.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/10/1447 AH.
//

import Foundation

final class LocalJSONLoader {
    
    static func loadDailyWeather(completion: @escaping (Result<[DailyWeather], Error>) -> Void)  {
        
        guard let url = Bundle.main.url(forResource: "SampleDailyWeather", withExtension: "json"
                                        
        ) else {
            DispatchQueue.main.async {
                completion(.failure(NSError(
                    domain: "LocalJSONLoader",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "Could not find SampleDailyWeather.json"]
                )))
            }
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let dailyWeather = try JSONDecoder().decode([DailyWeather].self, from: data)
            DispatchQueue.main.async {
                completion(.success(dailyWeather))
            }
            
        } catch {
            
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}

