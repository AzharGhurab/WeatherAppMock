//
//  MapWeatherViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 28/10/1447 AH.
//

import UIKit
import MapKit

final class MapWeatherViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = LocationManager()
    private let viewModel = MapWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Map"
        mapView.showsUserLocation = true
        
        setupLocation()
        setupGesture()
    }
    
    private func setupLocation() {
        locationManager.onLocationUpdate = { [weak self] location in
            guard let self = self else { return }
            
            print("Lat:", location.coordinate.latitude)
            print("Lon:", location.coordinate.longitude)
            
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 10000,
                longitudinalMeters: 10000
            )
            
            self.mapView.setRegion(region, animated: true)
        }
        
        locationManager.onAuthorizationDenied = {
            print("Permission denied")
        }
        
        locationManager.requestPermission()
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap))
        mapView.addGestureRecognizer(tap)
    }
    
    @objc private func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        viewModel.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude) { result in
            switch result {
            case .success(let weather):
                print("Temp:", weather.main.temp)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
