//
//  UITableView+extension.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 09/05/2019.
//

import UIKit

extension UITableView {
  func registerNib(cell className: String) {
    let cellNib = UINib(nibName: className, bundle: nil)
    self.register(cellNib, forCellReuseIdentifier: className)
  }
}
