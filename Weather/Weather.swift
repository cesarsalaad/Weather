//
//  Weather.swift
//  Weather
//
//  Created by Cesar Tesen on 3/25/20.
//  Copyright © 2020 Cesar Tesen. All rights reserved.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let coord: Coord
    let weather: [WeatherElement]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    init() {
        coord = Coord()
        weather = [WeatherElement()]
        base = "?"
        main = Main()
        wind = Wind()
        clouds = Clouds()
        dt = 0
        sys = Sys()
        timezone = 0
        id = 0
        name = "?"
        cod = 0
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
    
    init() {
        all = 0
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
    
    init() {
        lon = 0
        lat = 0
    }
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
    
    init() {
        temp = 0
        feelsLike = 0
        tempMin = 0
        tempMax = 0
        pressure = 0
        humidity = 0
        seaLevel = 0
        grndLevel = 0
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
    
    init() {
        country = "?"
        sunrise = 0
        sunset = 0
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    init() {
        id = 0
        main = "?"
        weatherDescription = "?"
        icon = "?"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    
    init() {
        speed = 0
        deg = 0
    }
}

