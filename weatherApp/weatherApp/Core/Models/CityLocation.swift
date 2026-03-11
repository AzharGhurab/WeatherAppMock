//
//  CityLocation.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 22/09/1447 AH.
//

import Foundation

struct CityLocation: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}
