//
//  DayDetailsViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 27/09/1447 AH.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
   private let viewModel: DayDetailsViewModel
    private let detailsView = DayDetailsView()
    
    init(viewModel: DayDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupData()
        animateIn()
    }
}
extension DayDetailsViewController {
    
    private func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        detailsView.dimView.addGestureRecognizer(tap)
        
        detailsView.closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        detailsView.dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
    }
    
    private func setupData() {
        detailsView.dateButton.setTitle(viewModel.selectedDateText, for: .normal)
        detailsView.dayLabel.text = viewModel.fullDateText
        detailsView.tempLabel.text = viewModel.temperatureText
        detailsView.descriptionLabel.text = viewModel.descriptionText
        detailsView.highLowLabel.text = viewModel.highLowText
    }
}

extension DayDetailsViewController {
    
   private func animateIn() {
        detailsView.containerView.transform = CGAffineTransform(translationX: 0, y: 500)
        detailsView.dimView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.detailsView.containerView.transform = .identity
            self.detailsView.dimView.alpha = 1
        }
    }
    
    @objc private func closeTapped() {
        UIView.animate(withDuration: 0.25, animations: {
            self.detailsView.containerView.transform = CGAffineTransform(translationX: 0, y: 500)
            self.detailsView.dimView.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
    @objc private func dateButtonTapped() {
        showDatePicker()
    }
    private func showDatePicker() {
        let datePickerViewController = DatePickerViewController()
        datePickerViewController.modalPresentationStyle = .overFullScreen
        
        datePickerViewController.onDateSelected = { [weak self] date in
            guard let self = self else { return }
            self.viewModel.updateSelectedDate(date)
            self.setupData()
        }
        
        present(datePickerViewController, animated: false)
    }
    
}
