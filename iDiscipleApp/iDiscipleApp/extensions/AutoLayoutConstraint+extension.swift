//
//  AutoLayoutConstraint+extension.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 22/05/2019.
//

import UIKit

extension NSLayoutConstraint {
  @discardableResult
  func set(enabled: Bool = true) -> Self {
    self.isActive = enabled
    return self
  }
}
