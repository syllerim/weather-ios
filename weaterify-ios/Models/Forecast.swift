//
//  Forecast.swift
//  weaterify-ios
//
//  Created by Mirellys Arteta Davila on 24/01/2018.
//  Copyright © 2018 syllerim. All rights reserved.
//

import Foundation

// MARK:- Coordinate

struct Coordinate {
    let lat: Double
    let lon: Double
}

extension Coordinate: Decodable {
    enum CoordinateKeys: String, CodingKey {
        case lat
        case lon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CoordinateKeys.self)
        lat = try values.decode(Double.self, forKey: .lat)
        lon = try values.decode(Double.self, forKey: .lon)
    }
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

struct City {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let population: Int64
}

extension City: Decodable {
    enum CityKeys: String, CodingKey {
        case id
        case name
        case coord
        case country
        case population
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CityKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        coord = try values.decode(Coordinate.self, forKey: .coord)
        country = try values.decode(String.self, forKey: .country)
        population = try values.decode(Int64.self, forKey: .population)
    }
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

struct Weather {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

extension Weather: Decodable {
    enum WeatherKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: WeatherKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        main = try values.decode(String.self, forKey: .main)
        description = try values.decode(String.self, forKey: .description)
        icon = try values.decode(String.self, forKey: .icon)
    }
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

struct Temp {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

extension Temp: Decodable {
    enum TempKeys: String, CodingKey {
        case day
        case min
        case max
        case night
        case eve
        case morn
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: TempKeys.self)
        day = try values.decode(Double.self, forKey: .day)
        min = try values.decode(Double.self, forKey: .min)
        max = try values.decode(Double.self, forKey: .max)
        night = try values.decode(Double.self, forKey: .night)
        eve = try values.decode(Double.self, forKey: .eve)
        morn = try values.decode(Double.self, forKey: .morn)
    }
}

extension Temp: Hashable {
    var hashValue: Int {
        var hash = 5381
        
        hash = ((hash << 5) &+ hash) &+ day.hashValue
        hash = ((hash << 5) &+ hash) &+ min.hashValue
        hash = ((hash << 5) &+ hash) &+ max.hashValue
        hash = ((hash << 5) &+ hash) &+ night.hashValue
        hash = ((hash << 5) &+ hash) &+ eve.hashValue
        hash = ((hash << 5) &+ hash) &+ morn.hashValue
        
        return hash
    }
    
    static func == (lhs: Temp, rhs: Temp) -> Bool {
        return lhs.day == rhs.day
            && lhs.min == rhs.min
            && lhs.max == rhs.max
            && lhs.night == rhs.night
            && lhs.eve == rhs.eve
            && lhs.morn == rhs.morn
    }
}

// MARK:- DailyForecast

struct DailyForecast {
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

extension DailyForecast: Decodable {
    enum DailyForecastKeys: String, CodingKey {
        case dt
        case temp
        case pressure
        case humidity
        case weather
        case speed
        case deg
        case clouds
        case rain
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DailyForecastKeys.self)
        dt = Date.init(timeIntervalSince1970: try values.decode(Double.self, forKey: .dt))
        temp = try values.decode(Temp.self, forKey: .temp)
        pressure = try values.decode(Double.self, forKey: .pressure)
        humidity = try values.decode(Int.self, forKey: .humidity)
        weather = try values.decode([Weather].self, forKey: .weather)
        speed = try values.decode(Double.self, forKey: .speed)
        deg = try values.decode(Int.self, forKey: .deg)
        clouds = try values.decode(Int.self, forKey: .clouds)
        rain = try values.decode(Double.self, forKey: .rain)
    }
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

struct Forecast {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [DailyForecast]
    let city: City
}

extension Forecast: Decodable {
    enum ForecastKeys: String, CodingKey {
        case cod
        case message
        case cnt
        case list
        case city
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: ForecastKeys.self)
        city = try values.decode(City.self, forKey: .city)
        cod = try values.decode(String.self, forKey: .cod)
        message = try values.decode(Double.self, forKey: .message)
        cnt = try values.decode(Int.self, forKey: .cnt)
        list = try values.decode([DailyForecast].self, forKey: .list)
        
    }
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

