//
//  ApiConnector.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation
import ApiConnector
import RxSwift
import SweetRouter

typealias Connection = ApiConnection<URLSessionDataTask>

final class ApiConnection<Provider: DataRequestType>: ApiConnectionType {
    typealias RouterType = Api
    typealias RequestType = Provider
    
    init() {}
    
    var token: String {
        let defaults = UserDefaults.standard
        guard let authorizationToken = defaults.string(forKey: App.keyToken) else {
            return ""
        }
        return authorizationToken
    }
    
    func getForecast(for city: String, cnt: String, units: String?) -> Observable<Forecast> {
        return requestObservable(at: .forecast(for: city, cnt, units, token)).toModel()
    }
    
    func getForecastBasedOnCoordinates(for lat: String, lon: String, cnt: String, units: String?) -> Observable<Forecast> {
        return requestObservable(at: .forecastBasedOnCoordinates(for: lat, lon, cnt, units, token)).toModel()
    }
}
