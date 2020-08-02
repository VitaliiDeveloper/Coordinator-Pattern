//
//  BaseViewController.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  var contentView:BaseView {
    return view as! BaseView
  }
  
  override var navigationController: VLNavigationController? {
    return super.navigationController as? VLNavigationController
  }
  
  override func loadView() {
    self.view = BaseView()
  }
  
  var subcribeKeyboardEvents = false {
    willSet {
      if newValue == false {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      } else {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentView.viewContentInitialization()
    contentView.setupViewContentConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.subcribeKeyboardEvents = true
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      
      self.contentView.contentScrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
  }
  
  @objc func keyboardWillHide(notification: NSNotification) {
    self.contentView.contentScrollView?.contentInset = .zero
  }
  
  func showNavigationBar() {
    self.navigationController?.showNavigationBar()
  }
  
  func hideNavigationBar() {
    self.navigationController?.hideNavigationBar()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    NotificationCenter.default.removeObserver(self)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
