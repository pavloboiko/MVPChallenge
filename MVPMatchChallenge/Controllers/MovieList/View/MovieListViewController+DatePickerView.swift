//
//  MovieListViewController+DatePickerView.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import UIKit

extension MovieListViewController: DatePickerViewDelegate {
    
    public func setupDatePickerView() {
        datePickerView.delegate = self
        view.addSubview(datePickerView)
        let margins = view.layoutMarginsGuide
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        datePickerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        datePickerTopConstraint = datePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        datePickerTopConstraint.isActive = true
        datePickerView.heightAnchor.constraint(equalToConstant: 260.0).isActive = true
    }
    
    func showDatePicker() {
        datePickerView.datePicker.date = Date()
        datePickerTopConstraint.constant = -260
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        })
    }
    
    func hideDatePicker() {
        datePickerTopConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        })
    }
    
    func datePickerDidCancel(_ sender: DatePickerView) {
        viewModel.didReset()
    }
    
    func datePicker(_ sender: DatePickerView, didSelect date: Date) {
        viewModel.didSelectFiltering(with: date)
        
    }
}

