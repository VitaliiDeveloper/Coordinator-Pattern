//
//  MeaningsWordDataModel.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import Foundation

struct MeaningsWordDataModel<ID:Codable>: Codable {
  let id:ID
  let wordId:Int?
  let difficultyLevel:Int?
  let partOfSpeechCode:String?
  let prefix:String?
  let text:String?
  let transcription:String?
  let updatedAt:String?
  let mnemonics:String?
  let images:[ImageDataModel]?
  let definition:DefinitionDataModel?
  let examples:[DefinitionDataModel]?
  let translation:TranslationWordDataModel?
  let meaningsWithSimilarTranslation:[MeaningsWithSimilarTranslation]?
  let alternativeTranslations:[AlternativeTranslations]?
  let previewUrl:String?
  let imageUrl:String?
  let soundUrl:String?
}

struct ImageDataModel:Codable {
  let url:String?
}

struct DefinitionDataModel:Codable {
  let text:String?
  let soundUrl:String?
}

struct MeaningsWithSimilarTranslation: Codable {
  let meaningId:Int?
  let frequencyPercent:String?
  let partOfSpeechAbbreviation:String?
  let translation:TranslationWordDataModel?
}

struct AlternativeTranslations:Codable {
  let text:String?
  let translation:TranslationWordDataModel?
}
