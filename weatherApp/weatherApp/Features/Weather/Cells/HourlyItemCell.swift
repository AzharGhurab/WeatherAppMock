//
//  HourlyItemCell.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/09/1447 AH.
//

import UIKit

class HourlyItemCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with model: HourlyWeather, isFirst: Bool) {
        
        if isFirst {
            timeLabel.text = "Now"
            timeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        } else {
            timeLabel.text = formatHour(from: model.dt)
            timeLabel.font = UIFont.systemFont(ofSize: 17)
        }
        
        temperatureLabel.text = "\(Int(model.temp))°"
        let condition = model.weather.first?.main ?? ""
        
        let date = Date(timeIntervalSince1970: TimeInterval(model.dt))
        let hour = Calendar.current.component(.hour, from: date)
        let isDay = hour >= 6 && hour <= 18
        
        switch condition {
        case "Clear":
            weatherImageView.image = UIImage(systemName: isDay ? "sun.max.fill" : "moon.stars.fill")
            
        case "Clouds":
            weatherImageView.image = UIImage(systemName: isDay ? "cloud.sun.fill" : "cloud.moon.fill")
            
        case "Rain":
            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
            
        default:
            weatherImageView.image = UIImage(systemName: isDay ? "sun.max.fill" : "moon.stars.fill")
        }
        
        weatherImageView.tintColor = .white
    }
    
    private func formatHour(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: date)
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

