//
//  InformationViewModel.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 29/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import BonMot

struct InformationViewModel {
    let logo = #imageLiteral(resourceName: "icn-logo")
    
    let description = "This is an example of iOS Weather App with Reactive/RxSwift and Redux development."
    
    var version: String {
        guard let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "v.1.0.0" }
        return ver
    }
}

extension InformationViewModel {
    
    // MARK:- Styles
    
    var backgroundColor: UIColor { return #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1) }
    var textColor: UIColor { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
    var fontFamilyName: String { return "HelveticaNeue-Light" }
    
    var paragraphStyle: NSMutableParagraphStyle {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        paragraph.lineSpacing = 5
        paragraph.paragraphSpacing = 30
        return paragraph
    }
    
    var descriptionStyled: NSAttributedString {
        let attrString = NSMutableAttributedString()
        let descriptionStyled = description.styled(with: .lineHeightMultiple(1), .font(UIFont(name: fontFamilyName, size: CGFloat(18))!), .color(textColor))
        attrString.append(descriptionStyled)
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: description.count))
        attrString.addAttribute(NSAttributedStringKey.kern, value: -0.24, range: NSMakeRange(0, description.count))
        return attrString
    }
    
    var versionStyled: NSAttributedString {
        return version.styled(with: .lineHeightMultiple(1), .font(UIFont(name: fontFamilyName, size: CGFloat(16))!), .color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)))
    }
}
