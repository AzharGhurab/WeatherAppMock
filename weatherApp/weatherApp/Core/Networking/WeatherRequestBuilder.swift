//
//  WeatherRequestBuilder.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 26/10/1447 AH.
//

import Foundation

struct WeatherRequestBuilder {
    
    private let scheme = "https"
    private let host = "api.openweathermap.org"
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func makeRequest(for endpoint: any EndpointType) -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endpoint.path
        
        var queryParameters = endpoint.queryParameters
        queryParameters["appid"] = apiKey
        
        if endpoint.shouldIncludeMetricUnits {
            queryParameters["units"] = "metric"
        }
        
        components.queryItems = queryParameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        return request
    }
}
