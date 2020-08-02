//
//  ApplicationCoordinator.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {
  //In this dict would be link Coordinator -> [UIViewController]
  //Adding coordinator with add(coordinator:)
  //adding controller with pushViewController
  private var _linkedCoordinatorsToController = [BaseCoordinator : [UIViewController]]()
  
  var childCoordinators = [BaseCoordinator]()
  
  override init() {
    super.init()
  }
  
  override init(navigationController: VLNavigationController) {
    super.init(navigationController: navigationController)
    
    self.navigationController.navigationDelegate = self
  }
  
  override func loadInitialCoordinator(with applicationCoordinator: ApplicationCoordinator) {
    super.loadInitialCoordinator(with: applicationCoordinator)
    
    let searchWordsCoordinator = SearchWordsCoordinator()
    searchWordsCoordinator.loadInitialCoordinator(with: applicationCoordinator)
  }
  
  func makeKeyAndVisibleWindow(window:UIWindow) {
    window.frame = UIScreen.main.bounds
    window.rootViewController = self.navigationController
    window.makeKeyAndVisible()
  }
  
  func pushViewController(_ viewController: UIViewController, animated: Bool, asRoot:Bool = false) {
    if asRoot {
      navigationController.setViewControllers([viewController], animated: animated)
    } else {
      navigationController.pushViewController(viewController, animated: animated)
    }
  }
  
  ///Would be add Root or Child coordinator.
  func add(coordinator: BaseCoordinator, asRoot:Bool = false) {
    if asRoot {
      self._linkedCoordinatorsToController = [BaseCoordinator : [UIViewController]]()
      self.removeAllCoordinators()
    }
    
    coordinator.applicationCoordinator = self
    
    if coordinator.navigationController == Optional.none {
      coordinator.navigationController = self.navigationController
    }
    
    if _linkedCoordinatorsToController[coordinator] == nil {
      _linkedCoordinatorsToController[coordinator] = []
    }
    
    childCoordinators.append(coordinator)
  }
  
  func remove(coordinator: BaseCoordinator?) {
    guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
    
    var index = childCoordinators.count - 1
    while index >= 0 {
      if childCoordinators[index] == coordinator {
        childCoordinators.remove(at: index)
        break
      }
      
      index -= 1
    }
    
    _linkedCoordinatorsToController[coordinator] = nil
  }
  
  fileprivate func removeLast() {
    self.childCoordinators.removeLast()
  }
  
  fileprivate func removeAllCoordinators() {
    self.childCoordinators.removeAll()
  }
}


//MARK: - VLNavigationControllerDelegate
extension ApplicationCoordinator: VLNavigationControllerDelegate {
  func present(viewController: UIViewController, animated: Bool) {
    
  }
  
  func pushViewController(viewController: UIViewController, from:Coordinator, animated: Bool, asRoot:Bool) {
    if let coordinator = from as? BaseCoordinator {
      if self._linkedCoordinatorsToController[coordinator] == nil {
        self._linkedCoordinatorsToController[coordinator] = [viewController]
      } else {
        self._linkedCoordinatorsToController[coordinator]!.append(viewController)
      }
    }
  }
  
  func popViewController(animated: Bool, viewController:UIViewController?) {
    if viewController == nil {
      return
    }
    
    var needToDeleteCoordinator = false
    var coordinator:BaseCoordinator?
    
    for(key, value) in self._linkedCoordinatorsToController {
      _ = value.first { (valueViewController) -> Bool in
        if viewController == valueViewController {
          if value.count <= 1 {
            needToDeleteCoordinator = true
          } else {
            needToDeleteCoordinator = false
          }
          
          coordinator = key
          return true
        }
        
        return false
      }
    }
    
    if self.childCoordinators.count > 1 {
      if needToDeleteCoordinator {
        self.remove(coordinator: coordinator!)
      } else if coordinator != nil && viewController != nil {
        for index in 0..<self._linkedCoordinatorsToController[coordinator!]!.count {
          if self._linkedCoordinatorsToController[coordinator!]![index] == viewController! {
            self._linkedCoordinatorsToController[coordinator!]!.remove(at: index)
          }
        }
      } else {
        assertionFailure("Error")
      }
    }
  }
  
  func popToRootViewController(animated: Bool, viewControllers:[UIViewController]?) {
    if viewControllers == nil || viewControllers?.count == 0 {
      return
    } else {
      DispatchQueue.global().async { [weak self] in
        self?.removeLinkedCoordinatorsToController(viewControllers: viewControllers!)
      }
    }
  }
  
  fileprivate func removeLinkedCoordinatorsToController(viewControllers:[UIViewController]) {
    var linkedCoordinatorsForRemoving = [BaseCoordinator]()
    
    for controller in viewControllers {
      for (key, value) in self._linkedCoordinatorsToController {
        var foundLinkedValue = false
        
        for linkedControllerIndex in 0..<value.count where controller == value[linkedControllerIndex] {
          self._linkedCoordinatorsToController[key]?.remove(at: linkedControllerIndex)
          
          if (self._linkedCoordinatorsToController[key]?.count ?? 0) < 1 {
            self._linkedCoordinatorsToController[key] = nil
            linkedCoordinatorsForRemoving.append(key)
          }
          
          foundLinkedValue = true
          break
        }
        
        if foundLinkedValue == true {
          break
        }
      }
    }
    
    for i in 0..<linkedCoordinatorsForRemoving.count {
      for j in 0..<self.childCoordinators.count where self.childCoordinators[j] == linkedCoordinatorsForRemoving[i] {
        self.childCoordinators.remove(at: j)
        break
      }
    }
  }
  
  @objc func dismiss() {
    
  }
}

