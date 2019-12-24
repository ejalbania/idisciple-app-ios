//
//  SpeakersView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 11/01/2019.
//

import UIKit

class SpeakersView: UIView {
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds

    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.backgroundColor = .white
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            //backgroundView.autoCenterInSuperview()

            backgroundView.autoPinEdge(toSuperviewEdge: .left)
            backgroundView.autoPinEdge(toSuperviewEdge: .right)
            backgroundView.autoPinEdge(toSuperviewEdge: .bottom)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

}
