//
//  HourlyForecastCell.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 19/09/1447 AH.
//

import UIKit

class HourlyForecastCell: UITableViewCell{
    
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
}
extension HourlyForecastCell{
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
}
extension HourlyForecastCell: UICollectionViewDataSource {
    
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
}
extension HourlyForecastCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
}
extension HourlyForecastCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHour = hourlyData[indexPath.item]
        onHourTapped?(selectedHour)
        
    }
}
