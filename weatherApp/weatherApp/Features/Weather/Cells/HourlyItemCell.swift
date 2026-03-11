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
        func configure(time: String, iconName: String, temperature: String) {
            timeLabel.text = time
            weatherImageView.image = UIImage(systemName: iconName)
            temperatureLabel.text = temperature
        }
    }
}
