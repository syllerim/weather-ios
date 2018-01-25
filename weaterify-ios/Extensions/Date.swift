//
//  Date.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation

extension Date {
    var toString: String {
        return Date.formatter.string(from: self)
    }
    
    var toRFC3339String: String {
        return Date.formatterRFC3339.string(from: self)
    }
    
    var toShortDateString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
    
    var toTimeString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var toDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: self)
    }
    
    var toFullTimeString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    var toShortTimeString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        return dateFormatter.string(from: self)
    }
    
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z"
        return formatter
    }
    
    static var formatterRFC3339: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }
    
    var midnightDate: Date {
        let userCalendar = Foundation.Calendar.current
        var dateComponents = userCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        dateComponents.setValue(23, for: .hour)
        dateComponents.setValue(59, for: .minute)
        dateComponents.setValue(59, for: .second)
        
        guard let date = userCalendar.date(from: dateComponents) else { return self }
        return date
    }
    
    var middayDate: Date {
        let userCalendar = Foundation.Calendar.current
        var dateComponents = userCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        dateComponents.setValue(00, for: .hour)
        dateComponents.setValue(00, for: .minute)
        dateComponents.setValue(00, for: .second)
        
        guard let date = userCalendar.date(from: dateComponents) else { return self }
        return date
    }
    
    var dateComponents: DateComponents {
        let userCalendar = Foundation.Calendar.current
        return userCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    }
}
