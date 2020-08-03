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
  
  private func loadSearchWordsViewController() {
    let controller = SearchWordsViewController()
    controller.delegate = self
    
    navigationController.pushViewController(controller, from: self, animated: true)
  }
  
  func loadWordDetailCoordinator(id:Int) {
    let coordinator = WordDetailCoordinator()
    
    self.applicationCoordinator.add(coordinator: coordinator)
    
    coordinator.openWordDetailViewController(wordID: id)
  }
}

//MARK: - SearchWordsViewControllerDelegate
extension SearchWordsCoordinator: SearchWordsViewControllerDelegate {
  func searchWordsViewController(_ viewController: SearchWordsViewController,
                                 didSelectAttributes: SearchWordTableViewCellAttributes) {
    self.loadWordDetailCoordinator(id: didSelectAttributes.id)
  }
}
