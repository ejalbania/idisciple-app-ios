//
//  AboutView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 10/05/2019.
//

import UIKit

class AboutView: UIView {

    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.gray
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = .white
        //view.layer.borderWidth = 0.5
        view.autoSetDimension(.height, toSize: self.screenSize.height - 162)
        view.autoSetDimension(.width, toSize: self.screenSize.width)
        
        return view
    }()
    
    lazy var whoLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "Who We Are"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var apbyTitleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "About APBY Conference"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var apbyContentLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "The APBY Conference is a gathering of Baptist youth in the Asia Pacific region that happens every 4 years. Under the Asia Pacific Baptist Federation, the conference includes youth of Baptist congregations from over 20 countries, uniting them in Christ and the global church."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.numberOfLines = 10
        
        return label
    }()
    
    lazy var iDiscTitleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "About iDISCIPLE Philippines"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var iDiscContentLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "iDISCIPLE Philippines is a ministry that exists to bring glory to God by making gospel-centered disciples of all nations, starting with the local churches in the Philippines. We do this through conferences and training courses for the youth, young adults, pastors, and ministry workers."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.numberOfLines = 10
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        
        backgroundView.addSubview(mainView);
        
        mainView.addSubview(whoLabel)
        
        mainView.addSubview(apbyTitleLabel)
        mainView.addSubview(apbyContentLabel)
        
        mainView.addSubview(iDiscTitleLabel)
        mainView.addSubview(iDiscContentLabel)
        
        //familyGroupTableView.isHidden = true
        //NSLog("%f", screenSize.height)
        
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
            backgroundView.autoPinEdge(toSuperviewEdge: .top)
            
            mainView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            mainView.autoPinEdge(toSuperviewEdge: .top, withInset: 1)
            
            whoLabel.autoPinEdge(.bottom, to: .top, of: mainView, withOffset: 40)
            //whoLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            whoLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            apbyTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            apbyTitleLabel.autoPinEdge(.top, to: .bottom, of: whoLabel, withOffset: 20)
            
            apbyContentLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            apbyContentLabel.autoPinEdge(.top, to: .bottom, of: apbyTitleLabel, withOffset: 5)
            apbyContentLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
            apbyContentLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            iDiscTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            iDiscTitleLabel.autoPinEdge(.top, to: .bottom, of: apbyContentLabel, withOffset: 20)
            
            iDiscContentLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            iDiscContentLabel.autoPinEdge(.top, to: .bottom, of: iDiscTitleLabel, withOffset: 5)
            iDiscContentLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
            iDiscContentLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
 
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}
