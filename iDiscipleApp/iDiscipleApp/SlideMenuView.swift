//
//  SlideMenuView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 22/10/2018.
//

import UIKit

class SlideMenuView: UIView {

    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.backgroundColor = .white
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        //view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(mainView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            backgroundView.autoPinEdge(toSuperviewEdge: .left)
            backgroundView.autoPinEdge(toSuperviewEdge: .right)
            backgroundView.autoPinEdge(toSuperviewEdge: .bottom)
            
            mainView.autoPinEdge(toSuperviewSafeArea: .top)
            mainView.autoPinEdge(toSuperviewSafeArea: .left)
            mainView.autoPinEdge(toSuperviewSafeArea: .right)
            mainView.autoPinEdge(toSuperviewEdge: .bottom)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }


}
