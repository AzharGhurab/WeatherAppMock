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
               return 5
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

               let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
               cell.textLabel?.text = "Weather Row \(indexPath.row)"
               
               return cell
           }
       }
