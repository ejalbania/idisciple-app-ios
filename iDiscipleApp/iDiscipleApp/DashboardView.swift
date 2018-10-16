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
    
    lazy var myProfileButton: DashboardButton = {
       let button = DashboardButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
        
        button.dashButtonLabel.text = "MY PROFILE"
        button.dashButtonImageView.image = UIImage(named: "dash_profile")
        
        return button
    }()
    
    lazy var speakersButton: DashboardButton = {
        let button = DashboardButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 230/255, green: 142/255, blue: 61/255, alpha: 1)

        button.dashButtonLabel.text = "SPEAKERS"
        button.dashButtonImageView.image = UIImage(named: "dash_speakers")
        
        return button
    }()
    
    lazy var communityButton: DashboardButton = {
        let button = DashboardButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 205/255, green: 55/255, blue: 61/255, alpha: 1.0)
    
        button.dashButtonLabel.text = "COMMUNITY"
        button.dashButtonImageView.image = UIImage(named: "dash_community")
        button.dashButtonImageView.contentMode = .scaleAspectFill
        
        return button
    }()
    
    lazy var scheduleButton: DashboardButton = {
        let button = DashboardButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 205/255, green: 55/255, blue: 61/255, alpha: 1.0)
        
        button.dashButtonLabel.text = "SCHEDULE"
        button.dashButtonImageView.image = UIImage(named: "dash_sched")
        button.dashButtonImageView.contentMode = .scaleAspectFill
        
        return button
    }()
    
    lazy var workshopButton: DashboardButton = {
        let button = DashboardButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 118/255, green: 173/255, blue: 92/255, alpha: 1.0)
        
        button.dashButtonLabel.text = "WORKSHOP"
        button.dashButtonImageView.image = UIImage(named: "dash_workshops")
        button.dashButtonImageView.contentMode = .scaleAspectFill
        
        return button
    }()
    
    lazy var resourcesButton: DashboardButton = {
        let button = DashboardButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
        
        button.dashButtonLabel.text = "RESOURCES"
        button.dashButtonImageView.image = UIImage(named: "dash_resources")
        
        return button
    }()
    
    lazy var directoryButton : UIButton = {
        let button = UIButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        
        button.setTitle("DIRECTORY", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(mainView)
        
        mainView.addSubview(bannerView)
        //mainView.addSubview(dashButtonsView)
        
        mainView.addSubview(myProfileButton)
        mainView.addSubview(speakersButton)
        mainView.addSubview(communityButton)
        mainView.addSubview(scheduleButton)
        mainView.addSubview(workshopButton)
        mainView.addSubview(resourcesButton)
        
        mainView.addSubview(directoryButton)
        
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
            
            let dashButtonsArray = [myProfileButton, speakersButton, communityButton, scheduleButton, workshopButton, resourcesButton]
            
            dashButtonsArray.first?.autoSetDimensions(to: CGSize(width: screenSize.width/2 - 30, height: 90))
            dashButtonsArray.first?.autoPinEdge(.top, to: .bottom, of: bannerView, withOffset: 20)
            dashButtonsArray.first?.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            var previousView: UIView?
            
            var count = 1
            for view in dashButtonsArray {
                
                //right
                if (count > 3){
                    if(count == 4){
                        view.autoSetDimensions(to: CGSize(width: screenSize.width/2 - 30, height: 90))
                        view.autoPinEdge(.top, to: .bottom, of: bannerView, withOffset: 20)
                        view.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
                    }else{
                        if let previousView = previousView {
                            view.autoSetDimensions(to: CGSize(width: screenSize.width/2 - 30, height: 90))
                            view.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
                            view.autoPinEdge(.top, to: .bottom, of: previousView, withOffset: 20)
                        }
                    }
                }
                else{
                    //left
                    if let previousView = previousView {
                        view.autoSetDimensions(to: CGSize(width: screenSize.width/2 - 30, height: 90))
                        view.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
                        view.autoPinEdge(.top, to: .bottom, of: previousView, withOffset: 20)
                    }
                }

                previousView = view
                count += 1
            }
            
            directoryButton.autoPinEdge(.top, to: .bottom, of: communityButton, withOffset: 30)
            directoryButton.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 50))
            directoryButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

}
