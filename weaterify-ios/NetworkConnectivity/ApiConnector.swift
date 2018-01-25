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
    
    var token: String = "95d190a434083879a6398aafd54d9e73"
    
    func getForecast(for city: String, cnt: String, units: String?) -> Observable<Forecast> {
        return requestObservable(at: .forecast(for: city, cnt, units, token)).toModel().debug()
    }
}
