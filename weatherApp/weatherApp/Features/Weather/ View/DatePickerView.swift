//
//  DatePickerView.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 27/10/1447 AH.
//

import UIKit

class DatePickerView: UIView {
    
    let dimView = UIView()
    let containerView = UIView()
    let datePicker = UIDatePicker()
    let doneButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        backgroundColor = .clear
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dimView)
        
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 24
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.title = "Done"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        
        doneButton.configuration = config
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonsStack = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 16
        buttonsStack.distribution = .fill
        buttonsStack.alignment = .center
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(datePicker)
        containerView.addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            
            dimView.topAnchor.constraint(equalTo: topAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 400),
            
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            buttonsStack.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            buttonsStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        datePicker.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
    }
}
