//
//  SearchWordDataModel.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import Foundation

struct SearchWordDataModel:Codable {
  let id:Int
  let text:String
  let meanings:[MeaningsWordDataModel<Int>]?
}
