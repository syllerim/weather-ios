//
//  Formatter.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 28/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation

extension Double {
    
    var toOneDecimal: String {
        return Double.formatterOneDigit.string(from: self)
    }
    
    static var formatterOneDigit: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }
    
}

