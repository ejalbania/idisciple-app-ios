//
//  LoginView.swift
//  iDiscipleApp
//
//  Created by eboy on 27/09/2018.
//

import UIKit
import PureLayout

class LoginView: UIView {
    
    let mainLogoHeight = 100
    
    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
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
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "Welcome!"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 35)
        label.numberOfLines = 1

        return label
    }()
    
    lazy var emailPasswordLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "Please enter your registered\n e-mail and password."
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "Invalid E-mail or Password!"
        label.textColor = .red
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
    
    lazy var logInButton : UIButton = {
        let button = UIButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 118/255, green: 173/255, blue: 92/255, alpha: 1)
        button.setTitle("LOG-IN", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        return button
    }()
    
    lazy var forgotPasswordButton : UIButton = {
        let button = UIButton.newAutoLayout()
        
        let attributedString = NSMutableAttributedString(string: "Forgot Password?")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textColor = UIColor(red: 64/255, green: 142/255, blue: 192/255, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
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
        
        mainView.addSubview(welcomeLabel)
        mainView.addSubview(emailPasswordLabel)
        mainView.addSubview(errorLabel)
        
        mainView.addSubview(emailTextfield)
        mainView.addSubview(passwordTextfield)
        mainView.addSubview(logInButton)
        mainView.addSubview(forgotPasswordButton)
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        rightView.addSubview(showPasswordButton)
        passwordTextfield.rightView = rightView
        passwordTextfield.rightViewMode = UITextField.ViewMode.always
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            // AutoLayout constraints
            //backgroundView.autoCenterInSuperview()
            
//            backgroundView.autoPinEdge(toSuperviewEdge: .top)
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
            
            welcomeLabel.autoPinEdge(.top, to: .bottom, of: mainLogo, withOffset: 30)
            welcomeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            emailPasswordLabel.autoPinEdge(.top, to: .bottom, of: welcomeLabel, withOffset: 10)
            emailPasswordLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 60))
            emailPasswordLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            errorLabel.autoPinEdge(.top, to: .bottom, of: emailPasswordLabel, withOffset: 0)
            errorLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 40))
            errorLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            emailTextfield.autoPinEdge(.top, to: .bottom, of: errorLabel, withOffset: 5)
            emailTextfield.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 45))
            emailTextfield.autoAlignAxis(toSuperviewAxis: .vertical)
            
            passwordTextfield.autoPinEdge(.top, to: .bottom, of: emailTextfield, withOffset: 15)
            passwordTextfield.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 45))
            passwordTextfield.autoAlignAxis(toSuperviewAxis: .vertical)
            
            logInButton.autoPinEdge(.top, to: .bottom, of: passwordTextfield, withOffset: 40)
            logInButton.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 50))
            logInButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            forgotPasswordButton.autoPinEdge(.bottom, to: .top, of: colorBar, withOffset: -30)
            forgotPasswordButton.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 40))
            forgotPasswordButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}
