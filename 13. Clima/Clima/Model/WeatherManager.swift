//
//  WeatherManager.swift
//  Clima
//
//  Created by 뜌딩 on 2023/11/02.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
  func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
  func didFailWithError(error: Error)
}


struct WeatherManager {
  
  let appId = Bundle.main.object(forInfoDictionaryKey: "WeatherAppID") as! String
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
  
  var delegate: WeatherManagerDelegate?
  
  func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let urlString = "\(weatherURL)&appId=\(appId)&lat=\(latitude)&lon=\(longitude)"
    performRequest(with: urlString)
  }
  
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&appId=\(appId)&q=\(cityName)"
    performRequest(with: urlString)
  }
  
  //networking
  func performRequest(with urlString: String) {
    //1. Create a URL
    if let url = URL(string: urlString) {
      //2. Create a URLSession
      let session = URLSession(configuration: .default)
      //3. Give the session a task
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          delegate?.didFailWithError(error: error!)
          return
        }
        
        if let safeData = data {
          if let weather = parseJSON(safeData) {
            delegate?.didUpdateWeather(self, weather: weather)
          }
        }
      }
      //4. Start the task
      task.resume()
    }
  }

  func parseJSON(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do {
      let decodeData = try decoder.decode(WeatherData.self, from: weatherData)

      let id = decodeData.weather[0].id
      let name = decodeData.name
      let temp = decodeData.main.temp
      
      let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      return weather
      
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
  
  
  
  
}
