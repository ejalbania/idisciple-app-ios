//
//  UITabBarItem.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//

import UIKit.UITabBarItem

extension UITabBarItem {
  @discardableResult
  func set(title: String) -> Self {
    self.title = title
    return self
  }
  
  @discardableResult
  func setIcon(image: UIImage) -> Self {
    self.image = image
    return self
  }
}
