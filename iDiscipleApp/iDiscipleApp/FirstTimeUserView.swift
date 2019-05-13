//
//  FirstTimeUserView.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/10/2018.
//

import UIKit

class FirstTimeUserView: UIView {

    let mainLogoHeight = 100
    
    var isKeyboardShowing = false
    var keyboardHeight = 0
    var backgroundHeightConstraint: NSLayoutConstraint?
    
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
    
    lazy var directionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.text = "First! Let's make\n your password\n personal."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 30)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        //label.text = "PASSWORDS DO NOT MATCH."
        label.text = "Minimum password input is 8 characters."
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Bold", size: 14)
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
    
    lazy var newPasswordTextfield : UITextField = {
        let textfield = UITextField.newAutoLayout()
        textfield.borderStyle = .bezel
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.isSecureTextEntry = true;
        
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 20)!
        ]
        
        textfield.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: attributes)
        
        var imageView = UIImageView(frame: CGRect(x: 10, y: 3, width: 20, height: 20))
        imageView.image = UIImage(named: "icon_password")
        imageView.contentMode = .scaleAspectFit
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        leftView.addSubview(imageView)
        
        textfield.leftView = leftView
        textfield.leftViewMode = UITextField.ViewMode.always
        
        return textfield
    }()
    
    lazy var reEnterPasswordTextfield : UITextField = {
        let textfield = UITextField.newAutoLayout()
        textfield.borderStyle = .bezel
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.isSecureTextEntry = true;
        
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 20)!
        ]
        
        textfield.attributedPlaceholder = NSAttributedString(string: "Re-Enter Password", attributes: attributes)
        
        var imageView = UIImageView(frame: CGRect(x: 10, y: 3, width: 20, height: 20))
        imageView.image = UIImage(named: "icon_password")
        imageView.contentMode = .scaleAspectFit
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        leftView.addSubview(imageView)
        
        textfield.leftView = leftView
        textfield.leftViewMode = UITextField.ViewMode.always
        
        return textfield
    }()
    
    lazy var changeAndGoButton : UIButton = {
        let button = UIButton.newAutoLayout()
        button.backgroundColor = UIColor(red: 118/255, green: 173/255, blue: 92/255, alpha: 1)
        button.setTitle("CHANGE PASSWORD & GO", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        return button
    }()
    
    lazy var showNewPasswordButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.setImage(UIImage(named:"icon_visible"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    lazy var showReEnterPasswordButton : UIButton = {
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
        
        self.backgroundColor = .white
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(mainView)
        
        mainView.addSubview(colorBar)
        mainView.addSubview(mainLogo)
        
        mainView.addSubview(directionLabel)

        mainView.addSubview(errorLabel)
        
        mainView.addSubview(newPasswordTextfield)
        mainView.addSubview(reEnterPasswordTextfield)
        mainView.addSubview(changeAndGoButton)
        
        let newPasswordRightView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        newPasswordRightView.addSubview(showNewPasswordButton)
        
        let reEnterPasswordRightView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        reEnterPasswordRightView.addSubview(showReEnterPasswordButton)
        
        newPasswordTextfield.rightView = newPasswordRightView
        newPasswordTextfield.rightViewMode = UITextField.ViewMode.always
        
        reEnterPasswordTextfield.rightView = reEnterPasswordRightView
        reEnterPasswordTextfield.rightViewMode = UITextField.ViewMode.always
        
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
            
            directionLabel.autoPinEdge(.top, to: .bottom, of: mainLogo, withOffset: 30)
            directionLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            errorLabel.autoPinEdge(.top, to: .bottom, of: directionLabel, withOffset: 10)
            errorLabel.autoSetDimensions(to: CGSize(width: screenSize.width - 40, height: 40))
            errorLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            
            newPasswordTextfield.autoPinEdge(.top, to: .bottom, of: errorLabel, withOffset: 15)
            newPasswordTextfield.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 45))
            newPasswordTextfield.autoAlignAxis(toSuperviewAxis: .vertical)
            
            reEnterPasswordTextfield.autoPinEdge(.top, to: .bottom, of: newPasswordTextfield, withOffset: 15)
            reEnterPasswordTextfield.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 45))
            reEnterPasswordTextfield.autoAlignAxis(toSuperviewAxis: .vertical)
            
            changeAndGoButton.autoPinEdge(.top, to: .bottom, of: reEnterPasswordTextfield, withOffset: 40)
            changeAndGoButton.autoSetDimensions(to: CGSize(width: screenSize.width - 70, height: 50))
            changeAndGoButton.autoAlignAxis(toSuperviewAxis: .vertical)
            
            shouldSetupConstraints = false
        }
        
        backgroundHeightConstraint?.autoRemove()
        if(isKeyboardShowing){
            backgroundHeightConstraint =  backgroundView.autoPinEdge(.bottom, to: .top, of: self, withOffset: screenSize.height - CGFloat(keyboardHeight))
        }else{
            backgroundHeightConstraint =  backgroundView.autoPinEdge(.bottom, to: .top, of: self, withOffset: screenSize.height)
        }
        
        super.updateConstraints()
    }

}
