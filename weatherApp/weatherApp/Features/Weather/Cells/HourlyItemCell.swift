//
//  HourlyItemCell.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/09/1447 AH.
//

import UIKit

private enum WeatherConditionType: String {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

class HourlyItemCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private let dayStartHour = 6
    private let dayEndHour = 18
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with model: HourlyWeather, isFirst: Bool) {
        
        if isFirst {
            timeLabel.text = "Now"
            timeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        } else {
            timeLabel.text = model.dt.toTimeString()
            timeLabel.font = UIFont.systemFont(ofSize: 17)
        }
        
        temperatureLabel.text = "\(Int(model.temp))°"
        
        let condition = WeatherConditionType(rawValue: model.weather.first?.main ?? "")
        let hour = Calendar.current.component(.hour, from: model.dt.toDate())
        let isDay = hour >= dayStartHour && hour <= dayEndHour
        
        switch condition {
        case .clear:
            weatherImageView.image = UIImage(systemName: isDay ? "sun.max.fill" : "moon.stars.fill")
            
        case .clouds:
            weatherImageView.image = UIImage(systemName: isDay ? "cloud.sun.fill" : "cloud.moon.fill")
            
        case .rain:
            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
            
        default:
            weatherImageView.image = UIImage(systemName: isDay ? "sun.max.fill" : "moon.stars.fill")
        }
        
        weatherImageView.tintColor = .white
    }
 private func loadImage(icon: String) {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.weatherImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

