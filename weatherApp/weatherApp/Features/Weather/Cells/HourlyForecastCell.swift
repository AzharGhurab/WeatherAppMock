//
//  HourlyForecastCell.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 19/09/1447 AH.
//

import UIKit

class HourlyForecastCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hourlyData: [HourlyWeather] = []
    var onHourTapped: ((HourlyWeather) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
        
        collectionView.register(
            UINib(nibName: "HourlyItemCell", bundle: nil),
            forCellWithReuseIdentifier: "HourlyItemCell"
        )
    }
    
    func configure(with data: [HourlyWeather]) {
        hourlyData = Array(data.sorted { $0.dt < $1.dt }.prefix(8))
        collectionView.reloadData()
    }
    
    func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "ha"
        return formatter.string(from: date)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HourlyItemCell",
            for: indexPath
        ) as! HourlyItemCell
        
        let item = hourlyData[indexPath.item]
        
        cell.configure(with: item, isFirst: indexPath.item == 0) 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHour = hourlyData[indexPath.item]
        onHourTapped?(selectedHour)
        
    }
}
