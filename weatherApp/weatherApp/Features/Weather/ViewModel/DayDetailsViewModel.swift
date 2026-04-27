//
//  DayDetailsViewModel.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 19/10/1447 AH.
//

import Foundation

class DayDetailsViewModel {
    
    private var model: DayDetailsModel
    private let dailyData: [DailyWeather]
    
    init(model: DayDetailsModel, dailyData: [DailyWeather]) {
        self.model = model
        self.dailyData = dailyData
    }
    
    var selectedDateText: String {
        model.date.toShortDateString()
        }
    
    
    var fullDateText: String {
        model.date.toFullDateString()
        }
    
    var temperatureText: String {
        "\(Int(model.maxTemp))°"
    }
    
    var descriptionText: String {
        model.description.capitalized
    }
    
    var highLowText: String {
        "H:\(Int(model.maxTemp))° L:\(Int(model.minTemp))°"
    }
    
    func updateSelectedDate(_ date: Date) {
        guard !dailyData.isEmpty else { return }
        
        let selectedTimestamp = date.timeIntervalSince1970
        
        let closest = dailyData.min(by: {
            abs(Double($0.dt) - selectedTimestamp) < abs(Double($1.dt) - selectedTimestamp)
        })
        
        if let matched = closest {
            model = DayDetailsModel(
                date: Date(timeIntervalSince1970: TimeInterval(matched.dt)),
                maxTemp: matched.temp.max,
                minTemp: matched.temp.min,
                description: matched.weather.first?.description ?? "Clear"
            )
        }
    }
}
