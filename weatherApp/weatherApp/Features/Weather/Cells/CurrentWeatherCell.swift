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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
