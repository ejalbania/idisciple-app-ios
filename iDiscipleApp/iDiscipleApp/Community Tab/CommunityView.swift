//
//  CommunityView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 23/04/2019.
//

import UIKit
import XLPagerTabStrip

class CommunityView: UIView {

    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var buttonBarView: ButtonBarView = {
        let view = ButtonBarView(frame: CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: 40.0), collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white

        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView.newAutoLayout()
        view.backgroundColor = UIColor.white

        return view
    }()
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(mainView)
        mainView.addSubview(buttonBarView)
        mainView.addSubview(scrollView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            
            mainView.autoPinEdge(toSuperviewSafeArea: .top)
            mainView.autoPinEdge(toSuperviewSafeArea: .left)
            mainView.autoPinEdge(toSuperviewSafeArea: .right)
            mainView.autoPinEdge(toSuperviewEdge: .bottom)
            
            buttonBarView.autoAlignAxis(toSuperviewAxis: .vertical)
            buttonBarView.autoSetDimensions(to: CGSize(width: screenSize.width, height: 50))
            buttonBarView.autoPinEdge(.bottom, to: .top, of: mainView, withOffset: 50)
            
            
            scrollView.autoAlignAxis(toSuperviewAxis: .vertical)
            scrollView.autoSetDimensions(to: CGSize(width: screenSize.width, height: screenSize.height-50))
            scrollView.autoPinEdge(.top, to: .bottom, of: buttonBarView, withOffset: 0)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }


}
