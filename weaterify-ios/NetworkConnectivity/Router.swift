//
//  Router.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import SweetRouter

struct Api: EndpointType {
    enum Route: RouteType {
        case forecast(for: String, String, String?, String)
        case forecastBasedOnCoordinates(for: String, String, String, String?, String)
        
        var route: URL.Route {
            switch self {
            case let .forecast(for: city, cnt, units, token):
                return .init(path: URL.Path("forecast", "daily"), query: URL.Query(("q", city), ("cnt", cnt), ("units", units), ("APPID", token)))
            case let .forecastBasedOnCoordinates(for: lat, lon, cnt, units, token):
                return .init(path: URL.Path("forecast", "daily"), query: URL.Query(("lat", lat), ("lon", lon), ("cnt", cnt),  ("units", units), ("APPID", token)))
            }
        }
    }
    
    static let current = URL.Env(.https, "api.openweathermap.org").at("data", "2.5")
}

