//
//  EndpointType.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 26/10/1447 AH.
//

import Foundation

protocol EndpointType {
    var path: String { get }
    var queryParameters: [String: String] { get }
    var shouldIncludeMetricUnits: Bool { get }
    var httpMethod: HTTPMethod { get }
    
}
