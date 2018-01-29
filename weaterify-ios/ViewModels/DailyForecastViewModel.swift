//
//  DailyForecastViewModel.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 25/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import BonMot

struct DailyForecastViewModel {
    let forecast: DailyForecast?
}

extension DailyForecastViewModel {
    
    var dayOfTheWeek: String {
        guard let forecast = forecast else { return "" }
        return forecast.dt.toDayOfTheWeekString
    }
    
    var iconURL: URL? {
        guard let iconName = forecast?.weather.first?.icon else { return nil }
        return URL(string: "http://openweathermap.org/img/w/" + iconName + ".png")
    }
    
    var temperatureMin: String {
        guard let today = forecast else { return "" }
        return today.temp.min.toString(with: 0)
    }
    
    var temperatureMax: String {
        guard let today = forecast else { return "" }
        return today.temp.max.toString(with: 0)
    }
    
    // MARK:- Styles
    
    var backgroundColor: UIColor { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
    var textColor: UIColor { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
    var ligtherTextColor: UIColor { return #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1) }
    var fontFamilyName: String { return "Helvetica-Light" }
    var fontSize:Int { return 16 }
    
    var dayOfTheWeekStringStyled: NSAttributedString {
        return dayOfTheWeek.styled(with: .lineHeightMultiple(1),
                                   .font(UIFont(name: fontFamilyName, size: CGFloat(fontSize))!),
                                   .color(textColor))
    }
    
    var tempMinStringStyled: NSAttributedString {
        return temperatureMin.styled(with: .lineHeightMultiple(1),
                                     .font(UIFont(name: fontFamilyName, size: CGFloat(fontSize))!),
                                     .color(ligtherTextColor))
    }
    
    var tempMaxStringStyled: NSAttributedString {
        return temperatureMin.styled(with: .lineHeightMultiple(1),
                                     .font(UIFont(name: fontFamilyName, size: CGFloat(fontSize))!),
                                     .color(textColor))
    }
}
