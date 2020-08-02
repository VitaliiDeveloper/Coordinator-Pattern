//
//  VLNavigationController.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

protocol VLNavigationControllerDelegate:AnyObject {
  func present(viewController: UIViewController, animated: Bool)
  func pushViewController(viewController: UIViewController, from:Coordinator, animated: Bool, asRoot:Bool)
  func popViewController(animated: Bool, viewController:UIViewController?)
  func popToRootViewController(animated: Bool, viewControllers:[UIViewController]?)
}

class VLNavigationController: UINavigationController {
  weak var navigationDelegate:VLNavigationControllerDelegate?
  
  var navigationBackButtonEnable = true
  
  func backButton(title:String = "", color:UIColor = .white) {
    if self.topViewController?.navigationItem.leftBarButtonItem == nil {
      let backButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(backButtonItemAction(_:)))
      backButtonItem.tintColor = color
      self.navigationBar.topItem?.backBarButtonItem = backButtonItem
    } else {
      self.topViewController?.navigationItem.leftBarButtonItem?.tintColor = color
      self.topViewController?.navigationItem.leftBarButtonItem?.title = title
    }
  }
  
  @objc private func backButtonItemAction(_ buttonItem:UIBarButtonItem) {
    _ = self.popViewController(animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationBar.isTranslucent = false
  }
  
  func showNavigationBar() {
    self.setNavigationBarHidden(false, animated: true)
  }
  
  func hideNavigationBar() {
    self.setNavigationBarHidden(true, animated: true)
  }
  
  func font(color:UIColor) {
    self.navigationBar.tintColor = color
  }
  
  func navigationBar(color:UIColor) {
    self.topViewController?.navigationController?.navigationBar.barTintColor = color
  }
  
  override var childForStatusBarStyle: UIViewController? {
    return self.topViewController
  }
  
  //MARK: - Navigation Methods
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    navigationDelegate?.present(viewController: viewControllerToPresent, animated: flag)
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: animated)
  }
  
  func pushViewController(_ viewController: UIViewController, from: Coordinator, animated: Bool) {
    self.pushViewController(viewController, from: from, animated: animated, asRoot: false)
  }
  
  func pushViewController(_ viewController: UIViewController, from: Coordinator, animated: Bool, asRoot:Bool = false) {
    navigationDelegate?.pushViewController(viewController: viewController, from: from, animated: animated, asRoot: asRoot)
    
    if asRoot {
      self.setViewControllers([viewController], animated: animated)
    } else {
      self.pushViewController(viewController, animated: animated)
    }
    
    let navigationController = (viewController.navigationController as? VLNavigationController)
    
    if !navigationBackButtonEnable {
      viewController.navigationItem.hidesBackButton = true
    } else {
      navigationController?.backButton(title: "", color: .blue)
    }
    
    
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    navigationController?.navigationBar.barTintColor = .white
  }
  
  override func popViewController(animated: Bool) -> UIViewController? {
    let controller = super.popViewController(animated: animated)
    
    navigationDelegate?.popViewController(animated: animated, viewController: controller)
    return controller
  }
  
  override func popToRootViewController(animated: Bool) -> [UIViewController]? {
    var controllerStack = [UIViewController]()
    if self.viewControllers.count > 1 {
      for index in 1..<self.viewControllers.count {
        controllerStack.append(self.viewControllers[index])
      }
    }
    
    navigationDelegate?.popToRootViewController(animated: animated, viewControllers:controllerStack)
    //For some reason popToRootViewController doesn't return viewControllers
    return super.popToRootViewController(animated: animated)
  }
}

