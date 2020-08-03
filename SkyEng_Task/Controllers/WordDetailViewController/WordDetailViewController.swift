//
//  WordDetailViewController.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/3/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

final class WordDetailViewController: BaseViewController {
  private var _wordID:Int?
  var wordID:Int {
    return _wordID ?? 0
  }
  
  convenience init(wordID:Int) {
    self.init(nibName: nil, bundle: nil)
    
    _wordID = wordID
  }
  
  override var contentView: WordDetailView {
    return self.view as! WordDetailView
  }
  
  override func loadView() {
    self.view = WordDetailView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = Localization.main.get(key: .meaning)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.meaningRequest(id: wordID) { (dataModels) in
      DispatchQueue.main.async { [weak self] in
        self?.fillingContentView(models: dataModels)
      }
    }
  }
  
  func meaningRequest(id:Int, complited:@escaping (([MeaningsWordDataModel<String>]?)->())) {
    NetworkManager.main.wordMeaning(by: id) { (dataModels) in
      complited(dataModels)
    }
  }
  
  func fillingContentView(models:[MeaningsWordDataModel<String>]?) {
    if let models = models {
      contentView.createAttributes(from: models)
    } else {
      let alert = UIAlertController(title: Localization.main.get(key: .empty_data), message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: Localization.main.get(key: .ok), style: .default, handler: nil))
      
      self.navigationController?.present(alert, animated: true)
      return
    }
  }
}
