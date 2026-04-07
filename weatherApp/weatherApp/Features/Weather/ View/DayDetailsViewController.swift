//
//  DayDetailsViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 27/09/1447 AH.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    let model: DayDetailsModel
    let dailyData: [DailyWeather]
       init(model: DayDetailsModel,dailyData: [DailyWeather]) {
           self.model = model
           self.dailyData = dailyData
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    private let dimView = UIView()
    private let containerView = UIView()
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let dateButton = UIButton(type: .system)
    
    private let dayLabel = UILabel()
    private let tempLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let highLowLabel = UILabel()
    
    override func viewDidLoad() {
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
            
            mainStackView.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 28),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -24)
               ])
           }
    
    private func setupData() {
        let shortFormatter = DateFormatter()
            shortFormatter.dateFormat = "dd MMM yyyy"

            let fullFormatter = DateFormatter()
            fullFormatter.dateFormat = "EEEE, dd MMMM yyyy"

            let selectedDateText = shortFormatter.string(from: model.date)
            let fullDateText = fullFormatter.string(from: model.date)

            dateButton.setTitle(selectedDateText, for: .normal)
            dayLabel.text = fullDateText
            
            tempLabel.text = "\(Int(model.maxTemp))°"
            descriptionLabel.text = model.description.capitalized
            highLowLabel.text = "H:\(Int(model.maxTemp))° L:\(Int(model.minTemp))°"
        }
    func updateUI(for date: Date) {
            
        guard !dailyData.isEmpty else { return }
           
           let selectedTimestamp = date.timeIntervalSince1970
           
           let closest = dailyData.min(by: {
               abs(Double($0.dt) - selectedTimestamp) < abs(Double($1.dt) - selectedTimestamp)
           })
           
           if let matched = closest {
                tempLabel.text = "\(Int(matched.temp.max))°"
                descriptionLabel.text = matched.weather.first?.description.capitalized ?? "Clear"
                highLowLabel.text = "H:\(Int(matched.temp.max))°  L:\(Int(matched.temp.min))°"
            }
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
        
        let vc = DatePickerViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        vc.onDateSelected = { [weak self] date in
            self?.updateUI(for: date)
            
        }
        
        present(vc, animated: false)
    }
    
}
