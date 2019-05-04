//
//  DelegatesProfileView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit

class DelegatesProfileView: UIView {

    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    let imageDimension = CGFloat(100)

    lazy var overlayBackgroundView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.withAlphaComponent(.black)(0.6)
        //view.backgroundColor = .white
        
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.white
        
        view.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: screenSize.height - (screenSize.height/3)))
        
        view.layer.cornerRadius = 20.0
        //view.layer.borderColor = UIColor.black.cgColor
        //view.layer.borderWidth = 1.0
        //view.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        
        return view
    }()
    
    lazy var profileTitleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        
        label.text = "DELEGATE PROFILE"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var profileImageView : UIImageView = {
        
        var image = UIImageView(image: UIImage(named: "creep"))
        image.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 200))
        image.backgroundColor = .darkGray
        image.contentMode = UIImageView.ContentMode.scaleAspectFit
        
        //image.layer.masksToBounds = false
        //image.layer.cornerRadius = imageDimension/2
        //image.clipsToBounds = true
        
        return image
    }()
    
    lazy var starredButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.autoSetDimension(.height, toSize: 50)
        button.autoSetDimension(.width, toSize: 50)
        button.setImage(UIImage(named: "star_selected"), for: .normal)
        //button.setImage(UIImage(named: "star_selected"), for: .highlighted)
        
        return button
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Nickname"
        label.textColor = .black
        //label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 22)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Full Name Here"
        label.textColor = .lightGray
        //label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var genderCountryLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "M/F, Country"
        label.textColor = .lightGray
        //label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var workshopsLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Attending Workshop Name Here & Another Worshop Name Here & Another Worshop Name Here"
        label.textColor = .lightGray
        //label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var familyGroupCaptionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Attending to"
        label.textColor = .lightGray
        //label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var familyGroupLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.backgroundColor = .yellow
        label.text = "Family Group #13 >"
        label.textColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
        //label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var dismissButton : UIButton = {
        let button = UIButton.newAutoLayout()
        
        let attributedString = NSMutableAttributedString(string: "Dismiss")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 22)
        
        return button
    }()
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(overlayBackgroundView)
        overlayBackgroundView.addSubview(mainView)
        
        mainView.addSubview(profileTitleLabel)
        mainView.addSubview(profileImageView)
       
        mainView.addSubview(starredButton)
        
        mainView.addSubview(nicknameLabel)
        mainView.addSubview(fullNameLabel)
        mainView.addSubview(genderCountryLabel)
        mainView.addSubview(workshopsLabel)
        
        mainView.addSubview(familyGroupCaptionLabel)
        mainView.addSubview(familyGroupLabel)
        
        mainView.addSubview(dismissButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            //backgroundView.autoCenterInSuperview()
            
            overlayBackgroundView.autoPinEdge(toSuperviewEdge: .top)
            overlayBackgroundView.autoPinEdge(toSuperviewEdge: .left)
            overlayBackgroundView.autoPinEdge(toSuperviewEdge: .right)
            overlayBackgroundView.autoPinEdge(toSuperviewEdge: .bottom)
            
            mainView.autoAlignAxis(toSuperviewAxis: .vertical)
            mainView.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            profileTitleLabel.autoPinEdge(.bottom, to: .top, of: mainView, withOffset:30)
            profileTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            profileImageView.autoAlignAxis(toSuperviewAxis: .vertical)
            profileImageView.autoPinEdge(.top, to: .bottom, of: profileTitleLabel, withOffset: 10)
            
            starredButton.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset:10)
            starredButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
            
            nicknameLabel.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset:20)
            nicknameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            fullNameLabel.autoPinEdge(.top, to: .bottom, of: nicknameLabel, withOffset:0)
            fullNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            genderCountryLabel.autoPinEdge(.top, to: .bottom, of: fullNameLabel, withOffset:0)
            genderCountryLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            workshopsLabel.autoPinEdge(.top, to: .bottom, of: genderCountryLabel, withOffset:5)
            workshopsLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            workshopsLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
            
            familyGroupCaptionLabel.autoPinEdge(.top, to: .bottom, of: workshopsLabel, withOffset:5)
            familyGroupCaptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            
            familyGroupLabel.autoPinEdge(.top, to: .bottom, of: workshopsLabel, withOffset:5)
            familyGroupLabel.autoPinEdge(.left, to: .right, of: familyGroupCaptionLabel, withOffset:5)
            
            dismissButton.autoPinEdge(.top, to: .bottom, of: mainView, withOffset: -50)
            dismissButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            
            shouldSetupConstraints = false
        }
        
        super.updateConstraints()
    }
    
}
