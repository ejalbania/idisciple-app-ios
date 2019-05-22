//
//  UINavigationController+extension.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 22/05/2019.
//

import UIKit

extension UINavigationController {
  @discardableResult
  func setRoot(viewController: UIViewController) -> Self {
    self.viewControllers = [viewController]
    return self
  }
}
