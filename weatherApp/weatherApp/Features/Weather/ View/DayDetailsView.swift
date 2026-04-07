//
//  DayDetailsView.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 20/10/1447 AH.
//

import UIKit

class DayDetailsView: UIView {
    
    let dimView = UIView()
    let containerView = UIView()
    
    let titleLabel = UILabel()
    let closeButton = UIButton(type: .system)
    let dateButton = UIButton(type: .system)
    
    let dayLabel = UILabel()
    let tempLabel = UILabel()
    let descriptionLabel = UILabel()
    let highLowLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

extension DayDetailsView {
    
    func setupUI() {
        backgroundColor = .clear
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dimView)
        
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 34
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        titleLabel.text = "Conditions"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setTitle("✕", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .gray
        closeButton.layer.cornerRadius = 22
        closeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        dateButton.setTitleColor(.white, for: .normal)
        dateButton.backgroundColor = .black
        dateButton.layer.cornerRadius = 22
        dateButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        
        dayLabel.textColor = .gray
        dayLabel.font = .systemFont(ofSize: 18, weight: .regular)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tempLabel.textColor = .white
        tempLabel.font = .systemFont(ofSize: 54, weight: .light)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.textColor = .gray
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        highLowLabel.textColor = .gray
        highLowLabel.font = .systemFont(ofSize: 18, weight: .regular)
        highLowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topStackView = UIStackView(arrangedSubviews: [dayLabel, tempLabel])
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        topStackView.spacing = 24
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomStackView = UIStackView(arrangedSubviews: [descriptionLabel, highLowLabel])
        bottomStackView.axis = .vertical
        bottomStackView.alignment = .leading
        bottomStackView.spacing = 10
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.spacing = 20
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(dateButton)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: topAnchor),
            dimView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.82),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            
            dateButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            dateButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            dateButton.heightAnchor.constraint(equalToConstant: 44),
            
            mainStackView.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 28),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -24)
        ])
    }
}
