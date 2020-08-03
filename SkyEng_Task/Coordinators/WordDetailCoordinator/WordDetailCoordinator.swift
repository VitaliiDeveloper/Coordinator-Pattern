//
//  WordDetailCoordinator.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/3/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import Foundation

final class WordDetailCoordinator: BaseCoordinator {
  func openWordDetailViewController(wordID:Int) {
    let controller = WordDetailViewController(wordID: wordID)
    self.navigationController.pushViewController(controller, from: self, animated: true)
  }
}
