//
//  DatePickerViewController.swift
//  weatherApp
//
//  Created by Azhar Ghurab on 18/10/1447 AH.
//
import UIKit

class DatePickerViewController: UIViewController {
    
    private let datePickerView = DatePickerView()
    
    var onDateSelected: ((Date) -> Void)?
    
    override func loadView() {
        view = datePickerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        animateIn()
    }
    private func setupActions() {
        
        datePickerView.doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        datePickerView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
    }
    
    private func animateIn() {
        datePickerView.containerView.transform = CGAffineTransform(translationX: 0, y: 400)
        UIView.animate(withDuration: 0.3) {
            self.datePickerView.containerView.transform = .identity
        }
    }
    
    @objc func doneTapped() {
        onDateSelected?(datePickerView.datePicker.date)
        dismiss(animated: false)
    }
    @objc func cancelTapped() {
        dismiss(animated: false)
    }
}

