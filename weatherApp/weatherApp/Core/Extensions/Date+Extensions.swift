//
//  Date+Extensions.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/10/1447 AH.
//

import Foundation

extension Date {
    
    private static let shortDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    private static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter
    }()
    
    private static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "ha"
        return formatter
    }()
    
    func toShortDayString() -> String {
        Date.shortDayFormatter.string(from: self)
    }
    
    func toFullDateString() -> String {
        Date.fullDateFormatter.string(from: self)
    }
    
    func toShortDateString() -> String {
        Date.shortDateFormatter.string(from: self)
    }
    
    func toTimeString() -> String {
        Date.timeFormatter.string(from: self)
    }
}
