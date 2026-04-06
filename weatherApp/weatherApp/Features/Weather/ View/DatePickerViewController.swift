//
//  DatePickerViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/10/1447 AH.
//
import UIKit

class DatePickerViewController: UIViewController {
    
    let dimView = UIView()
    let containerView = UIView()
    let datePicker = UIDatePicker()
    let doneButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)
    
    var onDateSelected: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dimView)
        
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 24
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.title = "Done"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        doneButton.configuration = config
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        let buttonsStack = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 16
        buttonsStack.distribution = .fill
        buttonsStack.alignment = .center
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(datePicker)
        containerView.addSubview(buttonsStack)
       
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 400),
            
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            buttonsStack.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            buttonsStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
               
        ])
        
        containerView.transform = CGAffineTransform(translationX: 0, y: 400)
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
        }
        datePicker.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
    }
    
    @objc func doneTapped() {
        onDateSelected?(datePicker.date)
        dismiss(animated: false)
    }
    @objc func cancelTapped() {
        dismiss(animated: false)
    }
}
