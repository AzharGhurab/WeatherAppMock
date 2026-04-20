//
//  CurrentWeatherCell.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 19/09/1447 AH.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func configure(with weather: WeatherResponse) {
        cityLabel.text = weather.name
        temperatureLabel.text = "\(Int(weather.main.temp))°"
        descriptionLabel.text = weather.weather.first?.description.capitalized ?? "Clear"
    }
    
}
