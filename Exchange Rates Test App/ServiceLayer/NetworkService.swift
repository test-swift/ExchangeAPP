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

protocol NetworkServiceProtocol {
    func getCurrencyRate(completion: @escaping  (Swift.Result<[Currency]?, Error>) -> ())
    func getCurrencyRateHistory(completion: @escaping (Swift.Result<[Currency]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol{
    
    func getCurrencyRate(completion: @escaping (Swift.Result<[Currency]?, Error>) -> Void) {
        guard let url = URL(string: "https://api.exchangeratesapi.io/latest") else {
            return }
          Alamofire.request(url,
                            method: .get,
                            parameters: ["base": "USD"])
          .validate()
          .responseJSON { response in
          switch response.result {
          case .success(let value):
            var result = [Currency]()
              let json = JSON(value)
              for jsonObject in json["rates"].dictionary!
                {
                    let val = Currency(name: jsonObject.key, rates: jsonObject.value.double!)
                    result.append(val)
            }
            completion(.success(result))
          case .failure(let error):
            completion(.failure(error))
          }
        }
}
    
        func getCurrencyRateHistory(completion: @escaping (Swift.Result<[Currency]?, Error>) -> Void) {
            guard let url = URL(string: "https://api.exchangeratesapi.io/history") else {
                return }
              Alamofire.request(url,
                                method: .get,
                                parameters: ["base": "USD",
                                             "symbols": "USD",
                                            "start_at":"2019-11-27",
                                            "end_at":"2019-12-03"]
                                )
              .validate()
              .responseJSON { response in
              switch response.result {
              case .success(let value):
                print(value)
              case .failure(let error):
                print(error)
              }
            }
    }
}
