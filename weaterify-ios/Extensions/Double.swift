//
//  Formatter.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 28/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation

extension Double {

    func toString(with fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self))  ?? "\(self)"
    }
}

