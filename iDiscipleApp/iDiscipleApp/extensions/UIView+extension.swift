//
//  UIView+extension.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 11/05/2019.
//

import UIKit.UIView

extension UIView {
  @discardableResult
  func round(corners:UIRectCorner, radius: CGFloat) -> Self {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
    
    return self
  }
  
  func dropShadow(scale: Bool = true) {
    self.layer.shadowColor = UIColor.darkGray.cgColor
    self.layer.shadowOffset = .zero
    self.layer.shadowOpacity = 0.5
    self.layer.shadowRadius = 5
    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
}


