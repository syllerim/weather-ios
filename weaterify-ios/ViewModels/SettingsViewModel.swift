//
//  SettingsViewModel.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 30/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import BonMot

struct SettingsViewModel {
    let titleLabel: String
    let valueLabel: String
}

extension SettingsViewModel {
    
    // MARK:- Styles

    var fontFamilyName: String { return "HelveticaNeue" }
    var fontSize: CGFloat { return 16.0 }
    
    var titleLabelStyled: NSAttributedString {
        return titleLabel.styled(with: .lineHeightMultiple(1),
                           .font(UIFont(name: fontFamilyName, size: CGFloat(fontSize))!),
                           .color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
    }
    
    var valueLabelStyled: NSAttributedString {
        return valueLabel.styled(with: .lineHeightMultiple(1),
                           .font(UIFont(name: fontFamilyName, size: CGFloat(fontSize))!),
                           .color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
    }
}
