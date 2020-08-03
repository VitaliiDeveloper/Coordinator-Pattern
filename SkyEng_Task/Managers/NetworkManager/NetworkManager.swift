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
    case wordSearch = "/api/public/v1/words/search"
    case wordMeaning = "/api/public/v1/meanings"
  }
  
  let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
  let scheme = "https"
  let host = "dictionary.skyeng.ru"
  
  func search(word:String, complited:@escaping (([SearchWordDataModel]?)->())) {
    var urlComponents = URLComponents()
    urlComponents.scheme = self.scheme
    urlComponents.host = self.host
    urlComponents.path = NetworkManagerKeys.wordSearch.rawValue
    urlComponents.queryItems = [
      URLQueryItem(name: "search", value: word)
    ]
    
    session.dataTask(with: urlComponents.url!) { (data, response, error) in
      complited(self.createModel(model: [SearchWordDataModel].self, data: data ?? Data()))
    }.resume()
  }
  
  func wordMeaning(by id:Int, complited:@escaping (([MeaningsWordDataModel<String>]?)->())) {
    var urlComponents = URLComponents()
    urlComponents.scheme = self.scheme
    urlComponents.host = self.host
    urlComponents.path = NetworkManagerKeys.wordMeaning.rawValue
    urlComponents.queryItems = [
      URLQueryItem(name: "ids", value: id.description)
    ]
    
    session.dataTask(with: urlComponents.url!) { (data, response, error) in
      complited(self.createModel(model: [MeaningsWordDataModel<String>].self, data: data ?? Data()))
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
}
