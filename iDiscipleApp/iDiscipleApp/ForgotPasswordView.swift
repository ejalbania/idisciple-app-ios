//
//  ForgotPasswordView.swift
//  iDiscipleApp
//
//  Created by eboy on 08/10/2018.
//

import UIKit
import PureLayout

class ForgotPasswordView: UIView {

    let mainLogoHeight = 100
    
    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.backgroundColor = .white
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor.white
        //view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    lazy var colorBar: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var mainLogo: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.backgroundColor = UIColor.gray
        view.autoSetDimensions(to: CGSize(width: mainLogoHeight, height: mainLogoHeight))
        
        return view
    }()
    
    lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "Forgot your\n Password?"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 30)
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "Enter your registered e-mail,\n we'll send you a link so you can\n set a new password."
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "★ Reset link sent! Check your e-mail."
        label.textColor = UIColor(red: 119/255, green: 175/255, blue: 93/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var emailTextfield : UITextField = {
        let textfield = UITextField.newAutoLayout()
        textfield.borderStyle = .bezel
        
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 20)!
        ]
        
        textfield.attributedPlaceholder = NSAttributedString(string: "E-mail Address", attributes: attributes)
        
        var imageView = UIImageView(frame: CGRect(x: 10, y: 3, width: 20, height: 20))
        imageView.image = UIImage(named: "icon_email")
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        leftView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        textfield.leftView = leftView
        textfield.leftViewMode = UITextField.ViewMode.always
        
        return textfield
    }()
    
    lazy var passwordTextfield : UITextField = {
        let textfield = UITextField.newAutoLayout()
        textfield.borderStyle = .bezel
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.isSecureTextEntry = true;
        
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 20)!
        ]
        
        textfield.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        
        var imageView = UIImageView(frame: CGRect(x: 10, y: 3, width: 20, height: 20))
        imageView.image = UIImage(named: "icon_password")
        imageView.contentMode = .scaleAspectFit
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        leftView.addSubview(imageView)
        
        textfield.leftView = leftView
        textfield.leftViewMode = UITextField.ViewMode.always
        
        
        return textfield
    }()
    
    lazy var emailResetLinkButton : UIButton = {
        let button = UIButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 69/255, green: 145/255, blue: 195/255, alpha: 1)
        button.setTitle("E-mail Reset Link", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        return button
    }()
    
    lazy var backToLoginButton : UIButton = {
        let button = UIButton.newAutoLayout()
        
        let attributedString = NSMutableAttributedString(string: "Back to Log-in")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        
        return button
    }()
    
    lazy var showPasswordButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.setImage(UIImage(named:"icon_visible"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
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
        
        mainView.addSubview(colorBar)
        mainView.addSubview(mainLogo)
        
        mainView.addSubview(forgotPasswordLabel)
        mainView.addSubview(instructionLabel)
        mainView.addSubview(statusLabel)

        mainView.addSubview(emailTextfield)
        mainView.addSubview(emailResetLinkButton)
        mainView.addSubview(backToLoginButton)
        
//        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
//        rightView.addSubview(showPasswordButton)
//        passwordTextfield.rightView = rightView
//        passwordTextfield.rightViewMode = UITextField.ViewMode.always
        
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
            
            mainLogo.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
            mainLogo.autoAlignAxis(toSuperviewAxis: .vertical)
            mainLogo.autoPinEdge(.bottom, to: .top, of: mainView, withOffset: CGFloat(mainLogoHeight + 50))
            
            colorBar.autoSetDimension(.height, toSize: 10.0)
            colorBar.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
            colorBar.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
            colorBar.autoPinEdge(.top, to: .bottom, of: mainView, withOffset: -10.0)
            
            forgotPasswordLabel.autoPinEdge(.top, to: .bottom, of: mainLogo, withOffset: 30)
            forgotPasswordLabel.autoAlignAxis(toSuperviewAxis: .vertical)

            instructionLabel.autoPinEdge(.top, to: .bottom, of: forgotPasswordLabel, withOffset: 5)
            instructionLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 80))
            instructionLabel.autoAlignAxis(toSuperviewAxis: .vertical)

            statusLabel.autoPinEdge(.top, to: .bottom, of: instructionLabel, withOffset: 5)
            statusLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 40))
            statusLabel.autoAlignAxis(toSuperviewAxis: .vertical)

            emailTextfield.autoPinEdge(.top, to: .bottom, of: statusLabel, withOffset: 10)
            emailTextfield.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 45))
            emailTextfield.autoAlignAxis(toSuperviewAxis: .vertical)
            
            emailResetLinkButton.autoPinEdge(.top, to: .bottom, of: emailTextfield, withOffset: 25)
            emailResetLinkButton.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 50))
            emailResetLinkButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            backToLoginButton.autoPinEdge(.bottom, to: .top, of: colorBar, withOffset: -35)
            backToLoginButton.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 40))
            backToLoginButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

}
