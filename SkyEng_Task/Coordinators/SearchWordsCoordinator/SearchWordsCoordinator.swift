//
//  SearchWordsCoordinator.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import Foundation

final class SearchWordsCoordinator: BaseCoordinator {
  override func loadInitialCoordinator(with applicationCoordinator: ApplicationCoordinator) {
    super.loadInitialCoordinator(with: applicationCoordinator)
    
    applicationCoordinator.add(coordinator: self, asRoot: true)
    
    self.loadSearchWordsViewController()
  }
  
  func loadSearchWordsViewController() {
    let controller = SearchWordsViewController()
    navigationController.pushViewController(controller, from: self, animated: true)
  }
}
