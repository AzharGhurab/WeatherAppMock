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
    func configure(with data: DailyWeather) {
        let date = Date(timeIntervalSince1970: TimeInterval(data.dt))
        dayLabel.text = date.toShortDayString()
        minTempLabel.text = "\(Int(data.temp.min))°"
        maxTempLabel.text = "\(Int(data.temp.max))°"
        weatherImageView.image = UIImage(systemName: "cloud.sun.fill")
    }
}


