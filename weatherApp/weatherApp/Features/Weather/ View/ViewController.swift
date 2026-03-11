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
    
    var sampleDaily: [DailyWeather] = [
        DailyWeather(dt: 1718874000, temp: Temperature(min: 18, max: 27), weather: []),
        DailyWeather(dt: 1718960400, temp: Temperature(min: 19, max: 28), weather: []),
        DailyWeather(dt: 1719046800, temp: Temperature(min: 20, max: 29), weather: []),
        DailyWeather(dt: 1719133200, temp: Temperature(min: 21, max: 30), weather: []),
        DailyWeather(dt: 1719219600, temp: Temperature(min: 22, max: 31), weather: []),
        DailyWeather(dt: 1719306000, temp: Temperature(min: 23, max: 32), weather: []),
        DailyWeather(dt: 1719392400, temp: Temperature(min: 24, max: 33), weather: []),
        DailyWeather(dt: 1719478800, temp: Temperature(min: 25, max: 34), weather: []),
        DailyWeather(dt: 1719565200, temp: Temperature(min: 26, max: 35), weather: []),
        DailyWeather(dt: 1719651600, temp: Temperature(min: 27, max: 36), weather: [])
    ]
    
    var sampleHourly = [
        HourlyWeather(dt: 1718874000, temp: 27, weather: []),
        HourlyWeather(dt: 1718877600, temp: 28, weather: []),
        HourlyWeather(dt: 1718881200, temp: 29, weather: []),
        HourlyWeather(dt: 1718884800, temp: 30, weather: []),
        HourlyWeather(dt: 1718888400, temp: 31, weather: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.45, green: 0.76, blue: 0.98, alpha: 1)
        
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        setupTableView()
        setupHeaderView()
        updateBackground()
      
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func setupHeaderView() {
        let headerCell = Bundle.main.loadNibNamed("CurrentWeatherCell", owner: self)?.first as! CurrentWeatherCell
        
        headerCell.cityLabel.text = "Riyadh"
        headerCell.temperatureLabel.text = "27°"
        headerCell.descriptionLabel.text = "Sunny"
        
        headerCell.backgroundColor = .clear
        headerCell.contentView.backgroundColor = .clear
        
        let headerView = headerCell.contentView
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 140)
        headerView.backgroundColor = .clear
        
        tableView.tableHeaderView = headerView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > 120 {
            navigationItem.title = "Riyadh"
        } else {
            navigationItem.title = ""
        }
    }
    
    func updateBackground() {
        
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let hour = Calendar.current.component(.hour, from: Date())
        let isDay = hour >= 5 && hour <= 18
        
        let gradient = CAGradientLayer()
        gradient.colors = WeatherGradientProvider.colors(isDay: isDay)
        gradient.frame = view.bounds
        
        view.layer.insertSublayer(gradient, at: 0)
    }
}
extension ViewController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = .clear
        
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
        return 1 + sampleDaily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "HourlyForecastCell",
                for: indexPath
            ) as! HourlyForecastCell

                cell.configure(with: sampleHourly)
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear

            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "DailyForecastCell",
                for: indexPath
            ) as! DailyForecastCell
            let dailyIndex = indexPath.row - 1
            let dayData = sampleDaily[dailyIndex]
            cell.configure(with: dayData)
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 130
        } else {
            return 60
        }
        
    }
}
