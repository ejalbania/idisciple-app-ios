//
//  SpeakersView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 11/01/2019.
//

import UIKit

class SpeakersView: UIView {

    lazy var backgroundView: UIView = {
        let view = UIView.newAutoLayout()
        //view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        view.backgroundColor = .white
        view.autoSetDimension(.height, toSize: screenSize.height)
        
        return view
    }()
    
    var shouldSetupConstraints = true
    let screenSize = UIScreen.main.bounds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundView)
        
//        backgroundView.addSubview(mainView)
//
//        mainView.addSubview(colorBar)
//        mainView.addSubview(mainLogo)
//
//        mainView.addSubview(welcomeLabel)
//        mainView.addSubview(emailPasswordLabel)
//        mainView.addSubview(errorLabel)
//
//        mainView.addSubview(emailTextfield)
//        mainView.addSubview(passwordTextfield)
//        mainView.addSubview(logInButton)
//        mainView.addSubview(forgotPasswordButton)
//
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
            //backgroundView.autoCenterInSuperview()

            backgroundView.autoPinEdge(toSuperviewEdge: .left)
            backgroundView.autoPinEdge(toSuperviewEdge: .right)
            backgroundView.autoPinEdge(toSuperviewEdge: .bottom)
            
//            mainView.autoPinEdge(toSuperviewSafeArea: .top)
//            mainView.autoPinEdge(toSuperviewSafeArea: .left)
//            mainView.autoPinEdge(toSuperviewSafeArea: .right)
//            mainView.autoPinEdge(toSuperviewEdge: .bottom)
//
//            mainLogo.autoSetDimensions(to: CGSize(width: 100.0, height: 100.0))
//            mainLogo.autoAlignAxis(toSuperviewAxis: .vertical)
//            mainLogo.autoPinEdge(.bottom, to: .top, of: mainView, withOffset: CGFloat(mainLogoHeight + 50))
//
//            colorBar.autoSetDimension(.height, toSize: 10.0)
//            colorBar.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
//            colorBar.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
//            colorBar.autoPinEdge(.top, to: .bottom, of: mainView, withOffset: -10.0)
//
//            welcomeLabel.autoPinEdge(.top, to: .bottom, of: mainLogo, withOffset: 30)
//            welcomeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
//
//            emailPasswordLabel.autoPinEdge(.top, to: .bottom, of: welcomeLabel, withOffset: 10)
//            emailPasswordLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 60))
//            emailPasswordLabel.autoAlignAxis(toSuperviewAxis: .vertical)
//
//            errorLabel.autoPinEdge(.top, to: .bottom, of: emailPasswordLabel, withOffset: 0)
//            errorLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 40))
//            errorLabel.autoAlignAxis(toSuperviewAxis: .vertical)
//
//            emailTextfield.autoPinEdge(.top, to: .bottom, of: errorLabel, withOffset: 5)
//            emailTextfield.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 45))
//            emailTextfield.autoAlignAxis(toSuperviewAxis: .vertical)
//
//            passwordTextfield.autoPinEdge(.top, to: .bottom, of: emailTextfield, withOffset: 15)
//            passwordTextfield.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 45))
//            passwordTextfield.autoAlignAxis(toSuperviewAxis: .vertical)
//
//            logInButton.autoPinEdge(.top, to: .bottom, of: passwordTextfield, withOffset: 40)
//            logInButton.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 50))
//            logInButton.autoAlignAxis(toSuperviewAxis: .vertical)
//
//            forgotPasswordButton.autoPinEdge(.bottom, to: .top, of: colorBar, withOffset: -30)
//            forgotPasswordButton.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 40))
//            forgotPasswordButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }

}
