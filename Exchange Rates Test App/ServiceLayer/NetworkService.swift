//
//  NetworkService.swift
//  Exchange Rates Test App
//
//  Created by Olha Skulska on 2019. 12. 06..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkServiceProtocol: AnyObject {
    func getCurrencyRate(completion: @escaping  (Swift.Result<Dictionary<String, Any>, Error>) -> ())
    func getCurrencyRateHistory(symbols: String, fromTo: (String, String), completion: @escaping (Swift.Result<Dictionary<String, Double>, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol{

     func getCurrencyRate(completion: @escaping  (Swift.Result<Dictionary<String, Any>, Error>) -> ()) {
        guard let url = URL(string: "https://api.exchangeratesapi.io/latest") else { return }
          Alamofire.request(url,
                            method: .get,
                            parameters: ["base": "USD"])
          .validate()
          .responseJSON { response in
          switch response.result {
          case .success(let value):
            let json = JSON(value)
            completion(.success(json["rates"].dictionaryObject!))
          case .failure(let error):
            completion(.failure(error))
          }
        }
}
    
    func getCurrencyRateHistory(symbols: String, fromTo: (String, String), completion: @escaping (Swift.Result<Dictionary<String, Double>, Error>) -> Void) {
            guard let url = URL(string: "https://api.exchangeratesapi.io/history") else {
                return }
              Alamofire.request(url,
                                method: .get,
                                parameters: ["base": "USD",
                                             "symbols": symbols,
                                             "start_at":fromTo.0,
                                             "end_at":fromTo.1]
                                )
              .validate()
              .responseJSON { response in
              switch response.result {
              case .success(let value):
                let res = JSON(value)
                var d = [String: Double]()
                for val in res["rates"]{
                    d[val.0] = val.1[symbols].double
                }
                completion(.success(d))
              case .failure(let error):
                completion(.failure(error))
              }
            }
    }
}
