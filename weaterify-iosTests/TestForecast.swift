//
//  TestForecast.swift
//  weaterify-iosTests
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import XCTest
@testable import weaterify_ios

class TestForecast: XCTestCase {
    var date: Date {
        return Date(timeIntervalSince1970: 1516791600)
    }
    var coordinate: Coordinate {
        return Coordinate(lat: 51.9229, lon: 4.4632)
        
    }
    var city: City {
        return City(id: 2747891, name: "Rotterdam", coord: self.coordinate, country: "NL", population: 598199)
    }
    var temp: Temp {
        return Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77)
    }
    var weather: Weather {
        return Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")
        
    }
    var dailyForecast: DailyForecast {
        return DailyForecast(dt: self.date,
                             temp: self.temp,
                             pressure: 1019.43,
                             humidity: 86,
                             weather: [self.weather],
                             speed: 14.85,
                             deg: 227,
                             clouds: 88,
                             rain: 2.83)
    }
    
    var forecast: Forecast {
        return Forecast(cod: "200", message: 0.4214264, cnt: 1, list: [self.dailyForecast], city: self.city)
    }
    
    func testCoordinates() {
        XCTAssertEqual(self.coordinate, Coordinate(lat: 51.9229, lon: 4.4632))
        XCTAssertEqual(self.coordinate.hashValue, Coordinate(lat: 51.9229, lon: 4.4632).hashValue)
        XCTAssertNotEqual(self.coordinate, Coordinate(lat: 51.9229, lon: 3.4632))
    }
    
    func testCity() {
        XCTAssertEqual(self.city, City(id: 2747891, name: "Rotterdam", coord: Coordinate(lat: 51.9229, lon: 4.4632), country: "NL", population: 598199))
        XCTAssertEqual(self.city.hashValue,
                       City(id: 2747891, name: "Rotterdam", coord: Coordinate(lat: 51.9229, lon: 4.4632), country: "NL", population: 598199).hashValue)
        XCTAssertNotEqual(self.city, City(id: 2747891, name: "Alicante", coord: Coordinate(lat: 51.9229, lon: 4.4632), country: "NL", population: 598199))
    }
    
    func testTemp() {
        XCTAssertEqual(self.temp, Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77))
        XCTAssertEqual(self.temp.hashValue,
                       Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77).hashValue)
        XCTAssertNotEqual(self.temp, Temp(day: 1.8, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77))
    }
    
    func testWeather() {
        XCTAssertEqual(self.weather, Weather(id: 500, main: "Rain", description: "light rain", icon: "10d"))
        XCTAssertEqual(self.weather.hashValue,
                       Weather(id: 500, main: "Rain", description: "light rain", icon: "10d").hashValue)
        XCTAssertNotEqual(self.weather, Weather(id: 500, main: "Rain", description: "light rain", icon: "10"))
    }
    
    func testDailyForecast() {
        XCTAssertEqual(self.dailyForecast, DailyForecast(dt: Date(timeIntervalSince1970: 1516791600),
                                                         temp: Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77),
                                                         pressure: 1019.43,
                                                         humidity: 86,
                                                         weather: [Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")],
                                                         speed: 14.85,
                                                         deg: 227,
                                                         clouds: 88,
                                                         rain: 2.83))
        XCTAssertEqual(self.dailyForecast.hashValue, DailyForecast(dt: Date(timeIntervalSince1970: 1516791600),
                                                                   temp: Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77),
                                                                   pressure: 1019.43,
                                                                   humidity: 86,
                                                                   weather: [Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")],
                                                                   speed: 14.85,
                                                                   deg: 227,
                                                                   clouds: 88,
                                                                   rain: 2.83).hashValue)
        XCTAssertNotEqual(self.dailyForecast, DailyForecast(dt: Date(timeIntervalSince1970: 1516791600),
                                                            temp: Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77),
                                                            pressure: 1019.43,
                                                            humidity: 86,
                                                            weather: [Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")],
                                                            speed: 20.85,
                                                            deg: 227,
                                                            clouds: 88,
                                                            rain: 2.83))
    }
    
    func testForecast() {
        XCTAssertEqual(self.forecast, Forecast(cod: "200",
                                               message: 0.4214264,
                                               cnt: 1,
                                               list: [DailyForecast(dt: Date(timeIntervalSince1970: 1516791600),
                                                                    temp: Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77),
                                                                    pressure: 1019.43,
                                                                    humidity: 86,
                                                                    weather: [Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")],
                                                                    speed: 14.85,
                                                                    deg: 227,
                                                                    clouds: 88,
                                                                    rain: 2.83)],
                                               city: City(id: 2747891, name: "Rotterdam",
                                                          coord: Coordinate(lat: 51.9229, lon: 4.4632),
                                                          country: "NL",
                                                          population: 598199)))
        XCTAssertEqual(self.forecast.hashValue, Forecast(cod: "200",
                                                         message: 0.4214264,
                                                         cnt: 1,
                                                         list: [DailyForecast(dt: Date(timeIntervalSince1970: 1516791600),
                                                                              temp: Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77),
                                                                              pressure: 1019.43,
                                                                              humidity: 86,
                                                                              weather: [Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")],
                                                                              speed: 14.85,
                                                                              deg: 227,
                                                                              clouds: 88,
                                                                              rain: 2.83)],
                                                         city: City(id: 2747891, name: "Rotterdam",
                                                                    coord: Coordinate(lat: 51.9229, lon: 4.4632),
                                                                    country: "NL",
                                                                    population: 598199)).hashValue)
        XCTAssertNotEqual(self.forecast, Forecast(cod: "200",
                                                  message: 0.4214264,
                                                  cnt: 1,
                                                  list: [DailyForecast(dt: Date(timeIntervalSince1970: 1516791600),
                                                                       temp: Temp(day: 282.77, min: 281.43, max: 282.77, night: 281.44, eve: 282.77, mor: 282.77),
                                                                       pressure: 1019.43,
                                                                       humidity: 86,
                                                                       weather: [Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")],
                                                                       speed: 14.85,
                                                                       deg: 227,
                                                                       clouds: 88,
                                                                       rain: 2.83)],
                                                  city: City(id: 2747891, name: "Rotterdam",
                                                             coord: Coordinate(lat: 51.9229, lon: 4.4632),
                                                             country: "NL",
                                                             population: 17)))
    }
}
