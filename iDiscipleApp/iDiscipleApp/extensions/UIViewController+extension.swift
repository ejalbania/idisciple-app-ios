//
//  UIViewController+extension.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//

import UIKit.UIViewController

// Builders
extension UIViewController {
  @discardableResult
  func set(title: String) -> Self {
    self.title = title
    return self
  }
}
