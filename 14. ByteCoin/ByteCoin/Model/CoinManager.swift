//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
  func didUpdatePrice(price: String, currency: String)
  func didFailWithError(error: Error)
}

struct CoinManager {
    
  let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
  let apiKey = Bundle.main.object(forInfoDictionaryKey: "CoinApiKey") as! String
  
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

  var delegate: CoinManagerDelegate?
  

  func getCoinPrice(for currency: String) {
    let coinUrl = "\(baseURL)/\(currency)?apikey=\(apiKey)"
    performRequest(with: coinUrl)
  }
  
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
          if let coinData = parseJSON(safeData) {
            let priceString = String(format: "%.2f", coinData.rate)
            delegate?.didUpdatePrice(price: priceString, currency: coinData.asset_id_quote)
          }
        }
      }
      //4. Start the task
      task.resume()
    }
  }
  
  func parseJSON(_ data: Data) -> CoinData? {
    let decoder = JSONDecoder()
    do {
      let decodeData = try decoder.decode(CoinData.self, from: data)
      let price = decodeData.rate
      let currency = decodeData.asset_id_quote
      
      let coinData = CoinData(rate: price, asset_id_quote: currency)
      
      return coinData
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
  
  
    
}
