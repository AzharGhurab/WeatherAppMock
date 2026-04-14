//
//  URLRequest+Extension.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 25/10/1447 AH.
//

import Foundation

extension URLRequest {
    init?(weatherEndpoint: WeatherEndpoint) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = weatherEndpoint.path
        components.queryItems = weatherEndpoint.queryItems
        
        guard let url = components.url else { return nil }
        self.init(url: url)
        self.httpMethod = weatherEndpoint.httpMethod.rawValue    }
}
