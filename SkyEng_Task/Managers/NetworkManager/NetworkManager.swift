//
//  NetworkManager.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2019 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

final class NetworkManager:NSObject, URLSessionDataDelegate {
  static let main = NetworkManager()
  
  enum NetworkManagerKeys:String {
    case wordMeaningSearch = "/api/public/v1/words/search"
  }
  
  lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
  let scheme = "https"
  let host = "dictionary.skyeng.ru"
  
  @objc func didEnterBackground(_ notification:NSNotification) {
    session = URLSession(configuration: .background(withIdentifier: "com.vl.WeatherDynamicAppIcon"), delegate: self, delegateQueue: nil)
  }
  
  @objc func willEnterForeground(_ notification:NSNotification) {
    session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
  }
  
  
  ///Be careful with completion block. Use [weak self] to be sure that retain cycle wasn't be
  func search(word:String, complited:@escaping (([SearchWordDataModel]?)->())) {
    var urlComponents = URLComponents()
    urlComponents.scheme = self.scheme
    urlComponents.host = self.host
    urlComponents.path = NetworkManagerKeys.wordMeaningSearch.rawValue
    urlComponents.queryItems = [
      URLQueryItem(name: "search", value: word)
    ]
    
    session.dataTask(with: urlComponents.url!) { (data, response, error) in
      complited(self.createModel(model: [SearchWordDataModel].self, data: data ?? Data()))
    }.resume()
  }
  
  //MARK: - Creating Model
  func createModel<T:Codable>(model:T.Type, data:Data) -> T? {
    let decoder = JSONDecoder()
    var decoderedOfferModel:T?
    do {
      decoderedOfferModel = try decoder.decode(model, from: data)
      return decoderedOfferModel
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
  
  //MARK: - URLSessionDataDelegate
}
