//
//  UIScrollView+Extensions.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation
import UIKit

extension UIScrollView {
    
    /// Method which returns whether a UIScrollView is at bottom or not
    ///
    /// - Returns: bool value
    func isAtBottom() -> Bool {
        return  contentOffset.y > (contentSize.height - frame.height)
    }
}
