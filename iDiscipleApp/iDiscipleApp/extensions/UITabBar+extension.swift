//
//  UITabBar.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//

import UIKit.UITabBar

extension UITabBar {
  @discardableResult
  func setTint(color: iDisciple.Color) -> Self {
    self.tintColor = color.value
    return self
  }
}

