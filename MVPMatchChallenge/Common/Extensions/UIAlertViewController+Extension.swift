//
//  UIAlertViewController+Extension.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /// Method which popups a UIAlertController with a given message
    ///
    /// - Parameter message: message string to be shown
    @discardableResult
    static func showAlert(withMessage  message: String) -> UIAlertController{
        let controller = UIAlertController(title: "Error Message",
                                           message: message,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(action)
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
        return controller
    }
}
