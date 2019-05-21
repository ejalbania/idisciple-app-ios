//
//  iDiscipleUISearchView.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 21/05/2019.
//

import UIKit
import RxSwift

class iDiscipleUISearchView: UIView {
  fileprivate var isActive: Variable<Bool> = Variable(false)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupNib()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.setupAesthetics()
  }
}

// Private classes
fileprivate extension iDiscipleUISearchView {
  func setupNib() {
    guard let nibView = Bundle.main.loadNibNamed("iDiscipleUISearchView", owner: self, options: [:])?
      .first as? UIView else {
      return
    }
    
    self.frame = nibView.bounds
    self.addSubview(nibView)
  }
  
  func setupAesthetics() {
    self
      .setBorder(width: 1, color: .lightGray)
      .setCorner(radius: 5)
  }
}

