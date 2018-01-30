//
//  MainStore.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 25/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import ReactiveReSwift
import CoreLocation

struct App {
    struct State {
        var route: Route = .dashboard
        var forecast: Forecast?
        var location: String?
        var unitTemperature: String
        var numberOfDaysForecast: Int
        
        init(forecast: Forecast? = nil, location: String? = nil, unitTemperature: String, numberOfDaysForecast: Int) {
            self.forecast = forecast
            self.location = location
            self.unitTemperature = unitTemperature
            self.numberOfDaysForecast = numberOfDaysForecast
        }
    }
    
    enum Actions: Action {
        //Side Effects
        case saveToken
        case getForecast(String?, String?, String?)
        //Actions
        case changeRoute(Route)
        case updateForecast(Forecast)
        case changeLocation(CLLocationCoordinate2D)
        case reloadData
        case insertCity(UIViewController)
        case updateCity(String)
        case insertNumberDays(UIViewController)
        case updateNumberOfDaysForecast(Int)
        case insertUnit(UIViewController)
        case updateUnitTemperature(String)
    }
    
    static var appReducer: Reducer<State> {
        return { action, state in
            var state = state
            
            switch action as? Actions {
            case let .changeRoute(route)?:
                state.route = route
            case let .updateForecast(forecast)?:
                state.forecast = forecast
                state.location = forecast.city.name
            case let .updateCity(city)?:
                state.location = city
            case let .updateNumberOfDaysForecast(days)?:
                if days < 6 {
                    state.numberOfDaysForecast = days
                }
            case let .updateUnitTemperature(unit)?:
                if unit == "Celcius" {
                    state.unitTemperature = "Celcius"
                } else {
                    state.unitTemperature = "Farenheit"
                }
            default:
                break
            }
            return state
        }
    }
}

let mainStore = Store(
    reducer: App.appReducer,
    observable: Variable(App.State(unitTemperature: "Celcius",  numberOfDaysForecast: 5)),
    middleware: App.middleware
)

extension App.State: Equatable {
    static func == (lhs: App.State, rhs: App.State) -> Bool {
        return lhs.route == rhs.route
            && lhs.forecast == rhs.forecast
    }
}
