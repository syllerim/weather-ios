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
        case updateUnitTemperature(String)
        case changeLocation(CLLocationCoordinate2D)
        case reloadData
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
            case let .updateUnitTemperature(unitTemperature)?:
                state.unitTemperature = unitTemperature
            default:
                break
            }
            return state
        }
    }
}

let mainStore = Store(
    reducer: App.appReducer,
    observable: Variable(App.State(unitTemperature: "metric",  numberOfDaysForecast: 15)),
    middleware: App.middleware
)

extension App.State: Equatable {
    static func == (lhs: App.State, rhs: App.State) -> Bool {
        return lhs.route == rhs.route
            && lhs.forecast == rhs.forecast
    }
}
