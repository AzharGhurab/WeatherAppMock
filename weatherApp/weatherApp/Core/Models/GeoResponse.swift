//
//  GeoResponse.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 10/10/1447 AH.
//

import Foundation

struct GeoResponse: Decodable {
    let name: String
    let lat: Double
    let lon: Double
}
