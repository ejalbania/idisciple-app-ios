//
//  HomeView.swift
//  iDiscipleApp
//
//  Created by eboy on 11/09/2018.
//

import UIKit
import PureLayout

class HomeView: UIView {
    
    var shouldSetupConstraints = true
    lazy var navBarHeight: CGFloat = 0.0
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    lazy var bannerView: UIImageView = {
        let view = UIImageView(frame: CGRect.zero)
        view.backgroundColor = UIColor.gray
        view.autoSetDimension(.height, toSize: screenSize.width / 3)
        
        return view
    }()
    
    lazy var menuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "sideMenu"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.layer.borderWidth = 1;
        
        return btn
    }()
    
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bannerView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            // AutoLayout constraints
            
            //let edgesInset: CGFloat = 10.0
            //let centerOffset: CGFloat = 62.0
            
            //let topOffset: CGFloat = navBarHeight + 20// Navbar height
            let topOffset: CGFloat = 88// Navbar height
            //print(topOffset)
            
            //bannerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
            bannerView.autoPinEdge(toSuperviewEdge: .top, withInset: topOffset)
            bannerView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            bannerView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

}
