//
//  DateTimeUtility.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation

struct DateTimeUtility {
    
    /// Converts string to date in 'yyyy-MM-dd' format
    ///
    /// - Parameter dateString: string of date in yyyy-MM-dd format
    /// - Returns: Date object
    static func getReleaseDateFromString(dateString: String) -> Date? {
        return DateFormatter.shortFormatDateFormatter.date(from: dateString)
    }
    
    
    /// Converts date to 'dd MMMM yyyy' string
    ///
    /// - Parameter shortFormatDate: Date object
    /// - Returns: String in dd MMMM yyyy format
    static func convertToLongDateFormat(from shortFormatDate: Date?) -> String?  {
        guard  let date = shortFormatDate else {
            return nil
        }
        return  DateFormatter.fullFormatDateFormatter.string(from: date)
    }
}
