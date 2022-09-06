//
//  DatePicketView.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation
import UIKit

protocol DatePickerViewDelegate: AnyObject {
    func datePickerDidCancel(_ sender: DatePickerView)
    func datePicker(_ sender: DatePickerView, didSelect date: Date)
}

class DatePickerView: UIView {
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: DatePickerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.backgroundColor = UIColor.black
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        delegate?.datePicker(self, didSelect: datePicker.date)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.datePickerDidCancel(self)
    }
}
