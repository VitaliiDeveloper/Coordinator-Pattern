//
//  SearchWordsViewController.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

final class SearchWordsViewController: BaseViewController {
  var timer = Timer()
  
  let searchController = UISearchController(searchResultsController: nil)
  
  override var contentView: SearchWordsView {
    return self.view as! SearchWordsView
  }
  
  override func loadView() {
    self.view = SearchWordsView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupSearchController()
  }
  
  fileprivate func setupSearchController() {
    self.title = Localization.main.get(key: .search)
    
    searchController.searchBar.placeholder = Localization.main.get(key: .i_want_to)
    searchController.searchResultsUpdater = self
    searchController.delegate = self
    
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  func searchRequest(word:String, complited:@escaping (([SearchWordDataModel]?)->())) {
    NetworkManager.main.search(word: word) { (dataModels) in
      complited(dataModels)
    }
  }
  
  func fillingContentView(models:[SearchWordDataModel]?) {
    if (models?.count ?? 0) == 0 {
      let alert = UIAlertController(title: Localization.main.get(key: .empty_data), message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: Localization.main.get(key: .ok), style: .default, handler: nil))
      
      self.navigationController?.present(alert, animated: true)
      return
    }
    
    if let models = models {
      self.contentView.createAttributes(from: models)
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
}

//MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension SearchWordsViewController: UISearchResultsUpdating, UISearchControllerDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let word = searchController.searchBar.text, searchController.searchBar.text?.count ?? 0 > 0 else { return }
    // Invalidate Timer each time as new char would be input
    timer.invalidate()
    
    // After Invalidating would be new loading
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
      self.searchRequest(word: word) { [unowned self] (dataModels) in
        DispatchQueue.main.async {
          self.fillingContentView(models: dataModels)
        }
      }
    })
  }
}
