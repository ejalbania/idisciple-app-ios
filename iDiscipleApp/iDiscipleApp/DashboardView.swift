//
//  DashboardView.swift
//  iDiscipleApp
//
//  Created by PCCWS User2 on 11/10/2018.
//

import UIKit

class DashboardView: UIView {

    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.backgroundColor = .white
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = .white
        //view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var bannerView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.autoSetDimension(.height, toSize: screenSize.height / 4)
        
        return view
    }()
    
//    lazy var dashButtonsView: UIView = {
//        let view = UIView.newAutoLayout()
//        view.backgroundColor = .white
//        view.autoSetDimension(.height, toSize: screenSize.height - (screenSize.height / 4))
//        return view
//    }()
    
    lazy var myProfileButton: UIButton = {
       let button = UIButton.newAutoLayout()
        //button.backgroundColor = UIColor(red: 64/255.0, green: 142/255.0, blue: 192/255.0, alpha: 1.0)
        button.backgroundColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitle("My Profile", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        return button
    }()
    
    lazy var speakersButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 230/255, green: 142/255, blue: 61/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitle("Speakers", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        //button.setImage(UIImage(named:"icon_visible"), for: .normal)
        //button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    lazy var communityButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 205/255, green: 55/255, blue: 61/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitle("Community", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        //button.setImage(UIImage(named:"icon_visible"), for: .normal)
        //button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(mainView)
        
        mainView.addSubview(bannerView)
        //mainView.addSubview(dashButtonsView)
        
        mainView.addSubview(myProfileButton)
        mainView.addSubview(speakersButton)
        mainView.addSubview(communityButton)
        
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
            
            bannerView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
            bannerView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            bannerView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            
            let dashButtonsArray = [myProfileButton, speakersButton, communityButton]
            
            dashButtonsArray.first?.autoSetDimensions(to: CGSize(width: screenSize.width/2 - 40, height: 90))
            dashButtonsArray.first?.autoPinEdge(.top, to: .bottom, of: bannerView, withOffset: 20)
            dashButtonsArray.first?.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            var previousView: UIView?
            for view in dashButtonsArray {
                if let previousView = previousView {
                    view.autoSetDimensions(to: CGSize(width: screenSize.width/2 - 40, height: 90))
                    view.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
                    view.autoPinEdge(.top, to: .bottom, of: previousView, withOffset: 20)
                }
                previousView = view
            }
    
//            myProfileButton.autoSetDimensions(to: CGSize(width: screenSize.width/2 - 40, height: 90))
//
//            myProfileButton.autoPinEdge(.top, to: .bottom, of: bannerView, withOffset: 20)
//            myProfileButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

}
