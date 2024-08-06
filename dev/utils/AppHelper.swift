//
//  AppHelper.swift
//  dev
//
//  Created by phan dam tung lam on 29/7/24.
//

import Foundation

struct AppHelper {
    static func parseDate(dateToParse: Date) -> String {
        // Create a DateFormatter
        let dateFormatter = DateFormatter()

        // Set the date format
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Convert the current date to a string
        let dateString = dateFormatter.string(from: dateToParse)
        
        return dateString
    }
}
