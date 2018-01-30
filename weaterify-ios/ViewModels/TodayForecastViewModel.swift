//
//  ForecastViewModel.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 25/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import BonMot

struct TodayForecastViewModel {
    let data: Forecast
    let unit: String?
}

extension TodayForecastViewModel {
    
    var todayForecast: DailyForecast? {
        guard let today = data.list.first else { return nil }
        return today
    }
    
    var city: String {
        return data.city.name
    }
    
    var description: String {
        guard let today = todayForecast else { return "" }
        guard let weatherFirst = today.weather.first else { return "" }
        return weatherFirst.main
    }
    
    var iconURL: URL? {
        guard let iconName = todayForecast?.weather.first?.icon else { return nil }
        return URL(string: "http://openweathermap.org/img/w/" + iconName + ".png")
    }
    
    var temperature: Double {
        guard let today = todayForecast else { return 0 }
        return today.temp.day
    }
    
    var temperatureString: String {
        let temp = temperature.toString(with: 1)
        guard let unit = unit else { return temp + "ºK" }
        switch unit {
        case "Celcius":
            return temp + "ºC"
        case "Farenheit":
            return temp + "ºF"
        default:
            return temp + "ºK"
        }
    }
    
    var date: Date {
        return todayForecast?.dt ?? Date()
    }
    
    var temperatureMin: String {
        guard let today = todayForecast else { return "" }
        return today.temp.min.toString(with: 1)
    }
    
    var temperatureMax: String {
        guard let today = todayForecast else { return "" }
        return today.temp.max.toString(with: 1)
    }
    
    // MARK:- Styles
    
    var backgroundColor: UIColor { return #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1) }
    var textColor: UIColor { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
    var fontFamilyName: String { return "HelveticaNeue" }
    
    var cityStyled: NSAttributedString {
        return city.styled(with: .lineHeightMultiple(1),
                           .font(UIFont(name: fontFamilyName, size: CGFloat(24))!),
                           .color(textColor))
    }
    
    var descriptionStyled: NSAttributedString {
        return description.styled(with: .lineHeightMultiple(1),
                                  .font(UIFont(name: fontFamilyName, size: CGFloat(18))!),
                                  .color(textColor))
    }
    
    var temperatureStyled: NSAttributedString {
        return temperatureString.styled(with: .lineHeightMultiple(1),
                                        .font(UIFont(name: fontFamilyName, size: CGFloat(48))!),
                                        .color(textColor))
    }
    
    var dayOfWeekStyled: NSAttributedString {
        return date.toDayOfTheWeekString.styled(with: .lineHeightMultiple(1),
                                                .font(UIFont(name: fontFamilyName, size: CGFloat(16))!),
                                                .color(textColor))
    }
    
    var dateStyled: NSAttributedString {
        return date.toDayString.styled(with: .lineHeightMultiple(1),
                                       .font(UIFont(name: fontFamilyName, size: CGFloat(16))!),
                                       .color(textColor))
    }
    
    var tempMinStyled: NSAttributedString {
        return temperatureMin.styled(with: .lineHeightMultiple(1),
                                     .font(UIFont(name: fontFamilyName, size: CGFloat(24))!),
                                     .color(textColor))
    }
    
    var tempMaxStyled: NSAttributedString {
        return temperatureMin.styled(with: .lineHeightMultiple(1),
                                     .font(UIFont(name: fontFamilyName, size: CGFloat(24))!),
                                     .color(textColor))
    }
}

