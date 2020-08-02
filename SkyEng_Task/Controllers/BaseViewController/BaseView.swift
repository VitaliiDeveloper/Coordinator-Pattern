//
//  BaseView.swift
//  SkyEng_Task
//
//  Created by Vitalii Lavreniuk on 8/2/20.
//  Copyright © 2020 Vitalii Lavreniuk. All rights reserved.
//

import UIKit

class BaseView:UIView {
  ///For controlling content inside when keyboard is appeared
  var contentScrollView:UIScrollView?
  
  private var defaultTapGesture:UITapGestureRecognizer?
  
  var useDefaultGestureTap:Bool = false {
    willSet {
      if newValue == true && defaultTapGesture == nil {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.defaultTapGestureAction(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        defaultTapGesture = tapGesture
        self.addGestureRecognizer(tapGesture)
      } else {
        if defaultTapGesture != nil {
          self.removeGestureRecognizer(defaultTapGesture!)
        }
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.firstInitialization()
    self.setupConstraints()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.firstInitialization()
    self.setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func firstInitialization() {
    
  }
  
  func setupConstraints() {
    
  }
  
  func viewContentInitialization() {
    
  }
  
  func setupViewContentConstraints() {
    
  }
  
  @objc func defaultTapGestureAction(_ tap:UITapGestureRecognizer) {
    
  }
}

