//
//  Forecast.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation

// MARK:- Coordinate

struct Coordinate: Decodable {
    let lat: Double
    let lon: Double
}

extension Coordinate: Hashable {
    var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ lat.hashValue
        hash = ((hash << 5) &+ hash) &+ lon.hashValue
        
        return hash
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.lat == rhs.lat
            && lhs.lon == rhs.lon
    }
}

// MARK:- City

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let population: Int64
}

extension City: Hashable {
    var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ id.hashValue
        hash = ((hash << 5) &+ hash) &+ name.hashValue
        hash = ((hash << 5) &+ hash) &+ coord.hashValue
        hash = ((hash << 5) &+ hash) &+ country.hashValue
        hash = ((hash << 5) &+ hash) &+ population.hashValue
        
        return hash
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.coord == rhs.coord
            && lhs.country == rhs.country
            && lhs.population == rhs.population
    }
}

// MARK:- Weather

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

extension Weather: Hashable {
    var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ id.hashValue
        hash = ((hash << 5) &+ hash) &+ main.hashValue
        hash = ((hash << 5) &+ hash) &+ description.hashValue
        hash = ((hash << 5) &+ hash) &+ icon.hashValue
        
        return hash
    }
    
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id
            && lhs.main == rhs.main
            && lhs.description == rhs.description
            && lhs.icon == rhs.icon
    }
}

// MARK:- Temp

struct Temp: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let mor: Double
}

extension Temp: Hashable {
    var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ day.hashValue
        hash = ((hash << 5) &+ hash) &+ min.hashValue
        hash = ((hash << 5) &+ hash) &+ max.hashValue
        hash = ((hash << 5) &+ hash) &+ night.hashValue
        hash = ((hash << 5) &+ hash) &+ eve.hashValue
        hash = ((hash << 5) &+ hash) &+ mor.hashValue
        
        return hash
    }
    
    static func == (lhs: Temp, rhs: Temp) -> Bool {
        return lhs.day == rhs.day
            && lhs.min == rhs.min
            && lhs.max == rhs.max
            && lhs.night == rhs.night
            && lhs.eve == rhs.eve
            && lhs.mor == rhs.mor
    }
}

// MARK:- DailyForecast

struct DailyForecast: Decodable {
    let dt: Date
    let temp: Temp
    let pressure: Double
    let humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg: Int
    let clouds: Int
    let rain: Double
}

extension DailyForecast: Hashable {
    var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ dt.hashValue
        hash = ((hash << 5) &+ hash) &+ temp.hashValue
        hash = ((hash << 5) &+ hash) &+ pressure.hashValue
        hash = ((hash << 5) &+ hash) &+ humidity.hashValue
        hash = weather.reduce(hash) { (($0 << 5) &+ $0) &+ $1.hashValue }
        hash = ((hash << 5) &+ hash) &+ speed.hashValue
        hash = ((hash << 5) &+ hash) &+ deg.hashValue
        hash = ((hash << 5) &+ hash) &+ clouds.hashValue
        hash = ((hash << 5) &+ hash) &+ rain.hashValue
        
        return hash
    }
    
    static func == (lhs: DailyForecast, rhs: DailyForecast) -> Bool {
        return lhs.dt == rhs.dt
            && lhs.temp == rhs.temp
            && lhs.pressure == rhs.pressure
            && lhs.humidity == rhs.humidity
            && lhs.weather == rhs.weather
            && lhs.speed == rhs.speed
            && lhs.deg == rhs.deg
            && lhs.clouds == rhs.clouds
            && lhs.rain == rhs.rain
    }
}

// MARK:- Forecast

struct Forecast: Decodable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [DailyForecast]
    let city: City
}

extension Forecast: Hashable {
    var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ cod.hashValue
        hash = ((hash << 5) &+ hash) &+ message.hashValue
        hash = ((hash << 5) &+ hash) &+ cnt.hashValue
        hash = list.reduce(hash) { (($0 << 5) &+ $0) &+ $1.hashValue }
        hash = ((hash << 5) &+ hash) &+ city.hashValue
        
        return hash
    }
    
    static func == (lhs: Forecast, rhs: Forecast) -> Bool {
        return lhs.cod == rhs.cod
        && lhs.message == rhs.message
        && lhs.cnt == rhs.cnt
        && lhs.list == rhs.list
        && lhs.city == rhs.city
    }
}

