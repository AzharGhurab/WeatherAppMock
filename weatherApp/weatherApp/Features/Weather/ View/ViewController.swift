//
//  ViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 15/09/1447 AH.
//

import UIKit

protocol CitySelectionDelegate: AnyObject {
    func didSelectCity(_ city: String)
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate ,CitySelectionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = WeatherViewModel()
    let backgroundGradient = CAGradientLayer()
    let searchBar = UISearchBar()
    
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
        HourlyWeather(dt: 1718888400, temp: 31, weather: []),
        HourlyWeather(dt: 1718892000, temp: 30, weather: []),
        HourlyWeather(dt: 1718895600, temp: 29, weather: []),
        HourlyWeather(dt: 1718899200, temp: 28, weather: []),
        HourlyWeather(dt: 1718902800, temp: 27, weather: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupTableView()
        setupHeaderView()
        updateBackground()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradient.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupHeaderView() {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        searchBar.frame = CGRect(x: 16, y: 8, width: tableView.bounds.width - 32, height: 44)
        searchBar.placeholder = "Search city"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .clear
        searchBar.isTranslucent = true
        searchBar.delegate = self
        
        let headerCell = Bundle.main.loadNibNamed("CurrentWeatherCell", owner: self)?.first as! CurrentWeatherCell
        
        headerCell.frame = CGRect(x: 0, y: 60, width: tableView.bounds.width, height: 140)
        headerCell.cityLabel.text = "Riyadh"
        headerCell.temperatureLabel.text = "27°"
        headerCell.descriptionLabel.text = "Sunny"
        headerCell.backgroundColor = .clear
        headerCell.contentView.backgroundColor = .clear
        
        containerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 210)
        containerView.addSubview(searchBar)
        containerView.addSubview(headerCell)
        
        tableView.tableHeaderView = containerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > 120 {
            navigationItem.title = "Riyadh"
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationItem.title = ""
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func updateBackground() {
        let hour = Calendar.current.component(.hour, from: Date())
        let isDay = hour >= 5 && hour <= 18
        
        backgroundGradient.colors = WeatherGradientProvider.colors(isDay: isDay)
        
        if backgroundGradient.superlayer == nil {
            view.layer.insertSublayer(backgroundGradient, at: 0)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text, !city.isEmpty else { return }
        print("City:", city)
        updateCity(city)
        searchBar.resignFirstResponder()
    }
    
    func updateCity(_ city: String) {

        if let header = tableView.tableHeaderView?.subviews.first(where: {$0 is CurrentWeatherCell}) as? CurrentWeatherCell {
            header.cityLabel.text = city
        }

    }

    func showDetails(for day: DailyWeather) {
        let detailsVC = DayDetailsViewController()
        detailsVC.modalPresentationStyle = .overFullScreen
        detailsVC.modalTransitionStyle = .crossDissolve

        detailsVC.selectedDateText = shortDate(from: day.dt)
        detailsVC.fullDateText = fullDate(from: day.dt)
        detailsVC.temperatureText = "\(Int(day.temp.max))°"
        detailsVC.descriptionText = day.weather.first?.description ?? "Clear"
        detailsVC.highLowText = "H:\(Int(day.temp.max))° L:\(Int(day.temp.min))°"

        present(detailsVC, animated: false)
    }
   
    func showDetails(for hour: HourlyWeather) {
        let detailsVC = DayDetailsViewController()
        detailsVC.modalPresentationStyle = .overFullScreen
        detailsVC.modalTransitionStyle = .crossDissolve

        detailsVC.selectedDateText = shortDate(from: hour.dt)
        detailsVC.fullDateText = fullDate(from: hour.dt)
        detailsVC.temperatureText = "\(Int(hour.temp))°"
        detailsVC.descriptionText = hour.weather.first?.description ?? "Clear"
        detailsVC.highLowText = "H:\(Int(hour.temp))° L:\(Int(hour.temp))°"

        present(detailsVC, animated: false)
    }
    func shortDate(from timestamp: Int?) -> String {
        guard let timestamp = timestamp else { return "No Date" }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }

    func fullDate(from timestamp: Int?) -> String {
        guard let timestamp = timestamp else { return "No Date" }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter.string(from: date)
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {

        let vc = CitiesViewController()
        vc.delegate = self

        navigationController?.pushViewController(vc, animated: true)

        return false
    }
    func didSelectCity(_ city: String) {
        updateCity(city)
    }
}

extension ViewController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
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
            cell.onHourTapped = { [weak self] selectedHour in
                self?.showDetails(for: selectedHour)
            }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let dailyIndex = indexPath.row - 1
            let selectedDay = sampleDaily[dailyIndex]
            showDetails(for: selectedDay)
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

