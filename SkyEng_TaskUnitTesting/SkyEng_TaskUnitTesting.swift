//
//  SkyEng_TaskUnitTesting.swift
//  SkyEng_TaskUnitTesting
//
//  Created by Vitalii Lavreniuk on 8/3/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

@testable import SkyEng_Task
import XCTest

class SkyEng_TaskUnitTesting: XCTestCase {
  let positiveLookingWords = ["Day", "Day to Day", "Five", "День", "Ночь"]
  let negativeLookingWords = ["asd", "Day to Day adsad", "uuiin", "Деньйцуфывфыв", "Ночьйцуйцуцй", ""]
  
  func testNetworkElements() {
    XCTAssertEqual("dictionary.skyeng.ru", NetworkManager.main.host)
    XCTAssertEqual("https", NetworkManager.main.scheme)
    
    XCTAssertEqual("/api/public/v1/meanings", NetworkManager.NetworkManagerKeys.wordMeaning.rawValue)
    XCTAssertEqual("/api/public/v1/words/search", NetworkManager.NetworkManagerKeys.wordSearch.rawValue)
  }
  
  func testPositiveNetworkSearch() {
    positiveLookingWords.forEach({ self.networkSearch(word: $0, positiveTest: true) })
  }
  
  func negetiveLookingWords() {
    self.negativeLookingWords.forEach({ self.networkSearch(word: $0, positiveTest: false) })
  }
  
  func networkSearch(word:String, positiveTest:Bool) {
    NetworkManager.main.search(word: word) { (models) in
      if positiveTest
      {
        XCTAssertNotNil(models)
        
        if let models = models {
          for model in models {
            XCTAssertNotNil(model.meanings)
            
            for meanings in model.meanings! {
              XCTAssertNotNil(meanings.wordId)
              XCTAssertNotNil(meanings.translation?.text)
            }
          }
        }
      }
      else
      {
        XCTAssertNil(models)
      }
    }
  }
}
