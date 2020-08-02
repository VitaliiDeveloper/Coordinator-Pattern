//
//  BaseCoordinator.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import Foundation

protocol Coordinator:AnyObject {
  var navigationController: VLNavigationController! { get set }
  
  func loadInitialCoordinator(with applicationCoordinator:ApplicationCoordinator)
}

class BaseCoordinator: Coordinator, Hashable {
  var applicationCoordinator:ApplicationCoordinator!
  var navigationController: VLNavigationController!
  
  lazy var unicodeScalarValue:Int = {
    var value = 0
    let unicodeScalars = String(describing: Self.self).unicodeScalars
    unicodeScalars.forEach { (unicode) in
      value += Int(unicode.value)
    }
    
    return value + self.navigationController.viewControllers.count
  }()
  
  init() {
    
  }
  
  ///Optional to use
  ///By default will be setter in ApplicationCoordinator
  ///When it will be added with method - add(coodenator:)
  init(navigationController: VLNavigationController) {
    self.navigationController = navigationController
  }
  
  func loadInitialCoordinator(with applicationCoordinator: ApplicationCoordinator) {
    self.applicationCoordinator = applicationCoordinator
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.navigationController)
    hasher.combine(unicodeScalarValue)
  }
  
  static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
    return lhs.unicodeScalarValue == rhs.unicodeScalarValue && lhs.navigationController == rhs.navigationController
  }
  
  deinit {
    print("Deinit \(String(describing: self.self))")
  }
}
