//
//  ApiRouterTest.swift
//  weaterify-iosTests
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import XCTest

@testable import weaterify_ios
import SweetRouter

class ApiRouterTest: XCTestCase {
    
    func testApiRouterURL() {
        XCTAssertEqual(Router<Api>.init(at: Api.Route.forecast(for: "Den Haag", "1", "imperial", "95d190a434083879a6398aafd54d9e73")).url.absoluteString, "https://api.openweathermap.org/data/2.5/forecast/daily?q=Den%20Haag&cnt=1&units=imperial&APPID=95d190a434083879a6398aafd54d9e73")
        XCTAssertEqual(Router<Api>.init(at: Api.Route.forecastBasedOnCoordinates(for: "4.355397", "52.091872", "7", "imperial", "95d190a434083879a6398aafd54d9e73")).url.absoluteString, "https://api.openweathermap.org/data/2.5/forecast/daily?lat=4.355397&lon=52.091872&cnt=7&units=imperial&APPID=95d190a434083879a6398aafd54d9e73")
    }
    
}
