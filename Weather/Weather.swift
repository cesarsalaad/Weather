//
//  Weather.swift
//  Weather
//
//  Created by Cesar Tesen on 3/25/20.
//  Copyright © 2020 Cesar Tesen. All rights reserved.
//

import Foundation

struct Weather
{
    let temp: Double
//    let feels_like: Double
//
//    let pressure: Int
//    let humidity: Int
//
//    let sea_level: Int
//    let grnd_level: Int
    init() {
        temp = 0
    }
}

extension Weather: JSONDecodable
{
  init(_ decoder: JSONDecoder) throws
  {
    self.temp = try decoder.value(forKey: "main")
  }
}
