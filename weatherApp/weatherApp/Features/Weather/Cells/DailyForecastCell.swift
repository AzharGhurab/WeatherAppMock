//
//  DailyForecastCell.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 19/09/1447 AH.
//

import UIKit

class DailyForecastCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(with data: DailyWeather) {
        dayLabel.text = formatDay(from: data.dt)
        minTempLabel.text = "\(Int(data.temp.min))°"
        maxTempLabel.text = "\(Int(data.temp.max))°"
        weatherImageView.image = UIImage(systemName: "cloud.sun.fill")
    }
    
    func formatDay(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}


