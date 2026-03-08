//
//  ViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 15/09/1447 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
           }
       }

extension ViewController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = 200
    
        
        tableView.register(
            UINib(nibName: "CurrentWeatherCell", bundle: nil),
            forCellReuseIdentifier: "CurrentWeatherCell"
        )
        
        tableView.register(
            UINib(nibName: "HourlyForecastCell", bundle: nil),
            forCellReuseIdentifier: "HourlyForecastCell"
        )
        
        tableView.register(
            UINib(nibName: "DailyForecastCell", bundle: nil),
            forCellReuseIdentifier: "DailyForecastCell"
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CurrentWeatherCell",
            for: indexPath
        ) as! CurrentWeatherCell
        
        cell.cityLabel.text = "Riyadh"
        cell.temperatureLabel.text = "27°"
        cell.descriptionLabel.text = "Sunny"
        
        return cell
    }
}
