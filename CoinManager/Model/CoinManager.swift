

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}


struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "9C39C65E-1823-4F9A-A29A-BBC14CB34844"    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
        performRequest(with: urlString, for: currency)
        
    }
    
    func performRequest(with urlString: String, for currency: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let coinPrice =  self.parseJason(safeData){
                        
                        let priceString = String(format: "%.2f", coinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                        //self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJason(_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            print(decodedData)
            //            let time = decodedData.time
            //            let asset_id_base = decodedData.asset_id_base
            //            let asset_id_quote = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            return rate
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


