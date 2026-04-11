//
//  CitiesViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 28/09/1447 AH.
//

import UIKit

class CitiesViewController: UIViewController {
    
    weak var delegate: CitySelectionDelegate?
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    
    var cities: [String] = []
    
    var filteredCities: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Search City"
        
        filteredCities = cities
        loadCities()
        setupSearchBar()
        setupTableView()
    }

private func loadCities() {
    guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
        print("cities.json not found")
        return
    }
    
    do {
        let data = try Data(contentsOf: url)
        cities = try JSONDecoder().decode([String].self, from: data)
        filteredCities = cities
    } catch {
        print("Failed to load cities: \(error)")
    }
}

    
    private func setupSearchBar() {
        searchBar.placeholder = "Search city"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredCities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = filteredCities[indexPath.row]
        delegate?.didSelectCity(city)
        
        navigationController?.popViewController(animated: true)
    }
}
extension CitiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
}
