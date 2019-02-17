//
//  UIView+AppHelper.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 09/02/2019.
//

import UIKit
import Foundation

extension AppHelper where Base: UIView {
    
    func dropShadow1(){
        
        let shadowPath = UIBezierPath(rect: self.base.bounds)
        self.base.layer.masksToBounds = false
        self.base.layer.shadowColor = UIColor.black.cgColor
        self.base.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.base.layer.shadowOpacity = 0.2
        self.base.layer.shadowPath = shadowPath.cgPath
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.base.layer.masksToBounds = false
        self.base.layer.shadowColor = UIColor.black.cgColor
        self.base.layer.shadowOpacity = 0.5
        self.base.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.base.layer.shadowRadius = 1
        
        self.base.layer.shadowPath = UIBezierPath(rect: self.base.bounds).cgPath
        self.base.layer.shouldRasterize = true
        self.base.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.base.layer.masksToBounds = false
        self.base.layer.shadowColor = color.cgColor
        self.base.layer.shadowOpacity = opacity
        self.base.layer.shadowOffset = offSet
        self.base.layer.shadowRadius = radius
        
        self.base.layer.shadowPath = UIBezierPath(rect: self.base.bounds).cgPath
        self.base.layer.shouldRasterize = true
        self.base.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
