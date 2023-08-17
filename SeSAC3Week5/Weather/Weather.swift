//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by 김지연 on 2023/08/17.
//

import Foundation
struct WeatherData: Codable {
    let id: Int
    let base: String
    let timezone: Int
    let name: String
    let main: Main
    let wind: Wind
    let coord: Coord
    let cod, dt, visibility: Int
    let weather: [Weather]
    let clouds: Clouds
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let tempMin: Double
    let pressure: Int
    let tempMax, temp: Double
    let humidity, grndLevel: Int
    let feelsLike: Double
    let seaLevel: Int

    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case pressure
        case tempMax = "temp_max"
        case temp, humidity
        case grndLevel = "grnd_level"
        case feelsLike = "feels_like"
        case seaLevel = "sea_level"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let icon, main, description: String
}

// MARK: - Wind
struct Wind: Codable {
    let deg: Int
    let speed, gust: Double
}
