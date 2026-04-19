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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Map"
        mapView.showsUserLocation = true
    }
}
