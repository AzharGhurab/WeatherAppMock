//
//  Int+Extensions.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/10/1447 AH.
//

import Foundation

extension Int {
    
    func toDate() -> Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    func toShortDayString() -> String {
        toDate().toShortDayString()
    }
    
    func toFullDateString() -> String {
        toDate().toFullDateString()
    }
    
    func toShortDateString() -> String {
        toDate().toShortDateString()
    }
    
    func toTimeString() -> String {
        toDate().toTimeString()
    }
    
}
