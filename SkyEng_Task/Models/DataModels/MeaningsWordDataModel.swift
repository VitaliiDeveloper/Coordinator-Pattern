//
//  MeaningsWordDataModel.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import Foundation

struct MeaningsWordDataModel: Codable {
  let id:Int
  let partOfSpeechCode:String?
  let translation:TranslationWordDataModel?
  let previewUrl:String?
  let imageUrl:String?
  let transcription:String?
  let soundUrl:String
}
