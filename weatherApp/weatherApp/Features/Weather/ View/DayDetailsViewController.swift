//
//  DayDetailsViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 27/09/1447 AH.
//

import UIKit

class DayDetailsViewController: UIViewController {
    

    private let dimView = UIView()
    private let containerView = UIView()
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let dateButton = UIButton(type: .system)
    
    private let dayLabel = UILabel()
    private let tempLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let highLowLabel = UILabel()
    
    var selectedDateText: String = "16 Mar 2026"
    var fullDateText: String = "Monday, 16 March 2026"
    var temperatureText: String = "12°"
    var descriptionText: String = "Mainly Clear"
    var highLowText: String = "H:21° L:12°"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
              setupUI()
              setupData()
              animateIn()
          }
          
          private func setupUI() {
              view.backgroundColor = .clear
              
              dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
              dimView.translatesAutoresizingMaskIntoConstraints = false
              view.addSubview(dimView)
              
              let tap = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
              dimView.addGestureRecognizer(tap)
              
              containerView.backgroundColor = .black
              containerView.layer.cornerRadius = 34
              containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
              containerView.translatesAutoresizingMaskIntoConstraints = false
              view.addSubview(containerView)
              
              titleLabel.text = "Conditions"
              titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
              titleLabel.translatesAutoresizingMaskIntoConstraints = false
              
              closeButton.setTitle("✕", for: .normal)
              closeButton.setTitleColor(.white, for: .normal)
              closeButton.backgroundColor = .gray
              closeButton.layer.cornerRadius = 22
              closeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
              closeButton.translatesAutoresizingMaskIntoConstraints = false
              closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
              
              dateButton.setTitle(selectedDateText, for: .normal)
              dateButton.setTitleColor(.white, for: .normal)
              dateButton.backgroundColor = .black
              dateButton.layer.cornerRadius = 22
              dateButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
              dateButton.translatesAutoresizingMaskIntoConstraints = false
              
              dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
              
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
              
              containerView.addSubview(titleLabel)
              containerView.addSubview(closeButton)
              containerView.addSubview(dateButton)
              containerView.addSubview(dayLabel)
              containerView.addSubview(tempLabel)
              containerView.addSubview(descriptionLabel)
              containerView.addSubview(highLowLabel)
              
              NSLayoutConstraint.activate([
                  dimView.topAnchor.constraint(equalTo: view.topAnchor),
                  dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                  dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                  dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                  
                  containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                  containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                  containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                  containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.82),
                  
                  titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
                  titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                  
                  closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                  closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
                  closeButton.widthAnchor.constraint(equalToConstant: 44),
                  closeButton.heightAnchor.constraint(equalToConstant: 44),
                  
                  dateButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
                  dateButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
                  dateButton.heightAnchor.constraint(equalToConstant: 44),
                  
                  dayLabel.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 28),
                  dayLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                  
                  tempLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 24),
                  tempLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                  
                  descriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20),
                  descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                  
                  highLowLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
                  highLowLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24)
              ])
          }
          
          private func setupData() {
              dateButton.setTitle(selectedDateText, for: .normal)
              dayLabel.text = fullDateText
              tempLabel.text = temperatureText
              descriptionLabel.text = descriptionText
              highLowLabel.text = highLowText
          }
          
          private func animateIn() {
              containerView.transform = CGAffineTransform(translationX: 0, y: 500)
              dimView.alpha = 0
              
              UIView.animate(withDuration: 0.3) {
                  self.containerView.transform = .identity
                  self.dimView.alpha = 1
              }
          }
          
          @objc private func closeTapped() {
              UIView.animate(withDuration: 0.25, animations: {
                  self.containerView.transform = CGAffineTransform(translationX: 0, y: 500)
                  self.dimView.alpha = 0
              }) { _ in
                  self.dismiss(animated: false)
              }
          }
    @objc private func dateButtonTapped() {
        showDatePicker()
    }
    private func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        
        let alert = UIAlertController(
            title: "Select Date",
            message: "\n\n\n\n\n\n\n\n\n",
            preferredStyle: .actionSheet
        )
        
        datePicker.frame = CGRect(x: 10, y: 20, width: 320, height: 200)
        alert.view.addSubview(datePicker)
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            let shortFormatter = DateFormatter()
            shortFormatter.dateFormat = "dd MMM yyyy"
            
            let fullFormatter = DateFormatter()
            fullFormatter.dateFormat = "EEEE, dd MMMM yyyy"
            
            self.selectedDateText = shortFormatter.string(from: datePicker.date)
            self.fullDateText = fullFormatter.string(from: datePicker.date)
            
            self.dateButton.setTitle(self.selectedDateText, for: .normal)
            self.dayLabel.text = self.fullDateText
        }
        
        alert.addAction(doneAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }

}
