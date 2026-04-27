//
//  MapWeatherViewController+Card.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 02/11/1447 AH.
//

import UIKit

extension MapWeatherViewController {
    
    func setupWeatherCard() {
        view.addSubview(weatherCard)
        view.bringSubviewToFront(weatherCard)
        
        weatherCard.translatesAutoresizingMaskIntoConstraints = false
        weatherCard.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openWeatherPopup))
        weatherCard.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            weatherCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            weatherCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            weatherCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            weatherCard.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        weatherCard.alpha = 0
        weatherCard.transform = CGAffineTransform(translationX: 0, y: 120)
        
        weatherCard.layer.cornerRadius = 24
        weatherCard.clipsToBounds = true
        weatherCard.backgroundColor = .clear
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        blurView.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.10)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.isUserInteractionEnabled = false
        weatherCard.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: weatherCard.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: weatherCard.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: weatherCard.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: weatherCard.trailingAnchor)
        ])
    }
    
    func showWeatherCard() {
        hideCardWorkItem?.cancel()
        
        weatherCard.isHidden = false
        weatherCard.alpha = 0
        weatherCard.transform = CGAffineTransform(translationX: 0, y: 120)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut]
        ) {
            self.weatherCard.alpha = 1
            self.weatherCard.transform = .identity
        }
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.hideWeatherCard()
        }
        
        hideCardWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: workItem)
    }
}
