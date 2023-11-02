//
//  WeatherData.swift
//  Clima
//
//  Created by 뜌딩 on 2023/11/02.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

//JSON으로 넘어오는 데이터
struct WeatherData: Codable {
  let name: String
  let main: Main
  let weather: [Weather]
}

struct Main: Codable {
  let temp: Double
}

struct Weather: Codable {
  let id: Int
}
