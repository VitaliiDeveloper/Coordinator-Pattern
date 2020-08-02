//
//  SceneDelegate.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var applicationCoordinator:ApplicationCoordinator!
  let navigationController = VLNavigationController()

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions)
  {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    
    applicationCoordinator = ApplicationCoordinator(navigationController: self.navigationController)
    applicationCoordinator.makeKeyAndVisibleWindow(window: self.window!)
    applicationCoordinator.loadInitialCoordinator(with: self.applicationCoordinator)
  }
}

