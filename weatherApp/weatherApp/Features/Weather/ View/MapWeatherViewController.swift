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
    private var selectedWeather: WeatherResponse?
     var hideCardWorkItem: DispatchWorkItem?
    
  lazy var weatherCard: CurrentWeatherCell = {
        let nib = UINib(nibName: "CurrentWeatherCell", bundle: nil)
        
        guard let cell = nib.instantiate(withOwner: nil, options: nil).first as? CurrentWeatherCell else {
            fatalError("Failed to load CurrentWeatherCell from nib")
        }
        
        return cell
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Map"
        mapView.showsUserLocation = true
        
        setupLocation()
        setupGesture()
        setupWeatherCard()
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
            MessagePresenter.showError("Location permission denied")
        }
        
        locationManager.requestPermission()
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap))
        mapView.addGestureRecognizer(tap)
    }
    func hideWeatherCard() {
        UIView.animate(withDuration: 0.25, animations: {
            self.weatherCard.alpha = 0
            self.weatherCard.transform = CGAffineTransform(translationX: 0, y: 120)
        }) { _ in
            self.weatherCard.isHidden = true
        }
    }
    
    @objc private func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        addPin(at: coordinate)
        mapView.setCenter(coordinate, animated: true)
        LoadingPresenter.show(on: view)
        viewModel.fetchWeather(
            lat: coordinate.latitude,
            lon: coordinate.longitude
        ) { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    LoadingPresenter.hide()
                    self.selectedWeather = weather
                    self.weatherCard.configure(with: weather)
                    self.showWeatherCard()
                    
                case .failure:
                    LoadingPresenter.hide()
                    MessagePresenter.showError("Failed to load weather")
                }
            }
        }
    }
    
    private func addPin(at coordinate: CLLocationCoordinate2D) {
        let annotations = mapView.annotations.filter { !($0 is MKUserLocation) }
        mapView.removeAnnotations(annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Selected Location"
        
        mapView.addAnnotation(annotation)
    }
    
    @objc func openWeatherPopup() {
        let weatherVC = WeatherViewController(
            nibName: "WeatherViewController",
            bundle: nil
        )
        weatherVC.selectedWeather = selectedWeather
        weatherVC.isPresentedFromMap = true
        weatherVC.modalPresentationStyle = .pageSheet
        
        if let sheet = weatherVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(weatherVC, animated: true)
    }
}
