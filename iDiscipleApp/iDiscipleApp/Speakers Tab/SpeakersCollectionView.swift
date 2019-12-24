//
//  SpeakersCollectionView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 16/01/2019.
//

import UIKit
import PureLayout
import Kingfisher

class SpeakersCollectionView: UIView {
    
    lazy var refreshControl = UIRefreshControl()
    lazy var speakersCV = UICollectionView()
    let screenSize = UIScreen.main.bounds
    var shouldSetupConstraints = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            //NSLog("Constraints")
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}
