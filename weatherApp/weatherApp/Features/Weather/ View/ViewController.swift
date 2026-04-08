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
class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate ,CitySelectionDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = WeatherViewModel()
    let backgroundGradient = CAGradientLayer()
    let searchBar = UISearchBar()
    var currentCity: String = "Riyadh"
    var hourlyData: [HourlyWeather] = []
    
    var sampleDaily: [DailyWeather] = [
        DailyWeather(dt: 1775088000, temp: Temperature(min: 18, max: 26), weather: [WeatherCondition(id: 1, main: "Clouds", description: "broken clouds", icon: "04d")]),
        DailyWeather(dt: 1775174400, temp: Temperature(min: 19, max: 27), weather: [WeatherCondition(id: 2, main: "Clear", description: "clear sky", icon: "01d")]),
        DailyWeather(dt: 1775260800, temp: Temperature(min: 20, max: 29), weather: [WeatherCondition(id: 3, main: "Rain", description: "light rain", icon: "10d")]),
        DailyWeather(dt: 1775347200, temp: Temperature(min: 21, max: 30), weather: [WeatherCondition(id: 4, main: "Clouds", description: "scattered clouds", icon: "03d")]),
        DailyWeather(dt: 1775433600, temp: Temperature(min: 22, max: 31), weather: [WeatherCondition(id: 5, main: "Clear", description: "sunny", icon: "01d")]),
        DailyWeather(dt: 1775520000, temp: Temperature(min: 17, max: 25), weather: [WeatherCondition(id: 6, main: "Rain", description: "moderate rain", icon: "10d")]),
        DailyWeather(dt: 1775606400, temp: Temperature(min: 16, max: 24), weather: [WeatherCondition(id: 7, main: "Clouds", description: "overcast clouds", icon: "04d")]),
        DailyWeather(dt: 1775692800, temp: Temperature(min: 23, max: 33), weather: [WeatherCondition(id: 8, main: "Clear", description: "hot sunny", icon: "01d")]),
        DailyWeather(dt: 1775779200, temp: Temperature(min: 21, max: 28), weather: [WeatherCondition(id: 9, main: "Clouds", description: "few clouds", icon: "02d")]),
        DailyWeather(dt: 1775865600, temp: Temperature(min: 20, max: 27), weather: [WeatherCondition(id: 10, main: "Clear", description: "clear sky", icon: "01d")])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupTableView()
        setupHeaderView()
        updateBackground()
        loadWeather(for: currentCity)
        
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
        headerCell.cityLabel.text = currentCity
        if let weather = viewModel.weather {
            headerCell.temperatureLabel.text = "\(Int(weather.main.temp))°"
            headerCell.descriptionLabel.text = weather.weather.first?.description.capitalized ?? "Clear"
        } else {
            headerCell.cityLabel.text = currentCity
            headerCell.temperatureLabel.text = "27°"
            headerCell.descriptionLabel.text = "Sunny"
        }
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
            navigationItem.title = currentCity
            
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
        currentCity = city
        
        if let header = tableView.tableHeaderView?.subviews.first(where: {$0 is CurrentWeatherCell}) as? CurrentWeatherCell {
            header.cityLabel.text = city
        }
        
    }
    
    func showDetails(for day: DailyWeather) {
        let model = DayDetailsModel(
               date: day.dt.toDate(),
               maxTemp: day.temp.max,
               minTemp: day.temp.min,
               description: day.weather.first?.description ?? "Clear"
               )
        let detailsViewModel = DayDetailsViewModel(model: model, dailyData: sampleDaily)
        let detailsVC = DayDetailsViewController(viewModel: detailsViewModel)

        detailsVC.modalPresentationStyle = .overFullScreen
        detailsVC.modalTransitionStyle = .crossDissolve
       
        present(detailsVC, animated: false)
    }
    
    func showDetails(for hour: HourlyWeather) {
        if let matched = sampleDaily.min(by: {
            abs(Double($0.dt - hour.dt)) < abs(Double($1.dt - hour.dt))
        }) {
            let model = DayDetailsModel(
                date: hour.dt.toDate(),
                maxTemp: matched.temp.max,
                minTemp: matched.temp.min,
                description: matched.weather.first?.description ?? "Clear"
            )
            let detailsViewModel = DayDetailsViewModel(model: model, dailyData: sampleDaily)
            let detailsVC = DayDetailsViewController(viewModel: detailsViewModel)
            detailsVC.modalPresentationStyle = .overFullScreen
            detailsVC.modalTransitionStyle = .crossDissolve
            
            
            present(detailsVC, animated: false)
        }
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        let vc = CitiesViewController()
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
        return false
    }
    func didSelectCity(_ city: String) {
        updateCity(city)
        loadWeather(for: city)
    }
    func loadWeather(for city: String) {
        viewModel.loadWeather(for: city) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.currentCity = city
                self.hourlyData = self.viewModel.hourlyForecast
                self.setupHeaderView()
                self.tableView.reloadData()
                
            case .failure(let error):
                print("Weather error:", error.localizedDescription)
            }
        }
    }
}

extension WeatherViewController {
    
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
            cell.configure(with: hourlyData)
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
