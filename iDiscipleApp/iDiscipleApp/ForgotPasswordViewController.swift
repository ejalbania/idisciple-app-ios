//
//  ForgotPasswordViewController.swift
//  iDiscipleApp
//
//  Created by eboy on 08/10/2018.
//

import UIKit
import SwiftyJSON

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    var forgotPasswordView: ForgotPasswordView!
    var activeField: UITextField?
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        forgotPasswordView = ForgotPasswordView(frame: CGRect.zero)
        self.view.addSubview(forgotPasswordView)
        
        // AutoLayout
        forgotPasswordView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        forgotPasswordView.colorBar.image = UIImage(named: "iDisc_colorBar")
        forgotPasswordView.mainLogo.image  = UIImage(named: "iDisc_logo")
        
        forgotPasswordView.statusLabel.isHidden = true
        
        forgotPasswordView.backToLoginButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        forgotPasswordView.emailResetLinkButton.addTarget(self, action: #selector(emailResetLinkPressed(sender:)), for: .touchUpInside)
        
        forgotPasswordView.emailTextfield.delegate = self
        
        if(screenSize.height <= 667){
            registerForKeyboardNotifications()
        }
    }
    
    deinit {
        
        if(screenSize.height <= 667){
            deregisterFromKeyboardNotifications()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backToLogin(sender: UIButton!){
        
        self.view.endEditing(true)
        //let newViewController = ForgotPasswordViewController()
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func emailResetLinkPressed(sender: UIButton!){
        
        self.view.endEditing(true)
        
        let urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.forgotPassword
        let paramsDict = ["email" : forgotPasswordView.emailTextfield.text ?? ""] as [String : Any]
        
        //debugPrint("\(urlString) + \(paramsDict["email"] ?? "")")
        self.appHelper.alert(message: "Checking Email..")
        
        ApiManager.sharedInstance.postDataWithRequest(requestUrl: urlString, params: paramsDict, onSuccess: { json in
            DispatchQueue.main.async {
                
                self.appHelper.dismissAlert()
                
                let jsonValue = JSON(json)
                //debugPrint("\(jsonValue["data"])")
                
                for (_, subJson) in jsonValue["data"] {
                    debugPrint("\(subJson["name"])")
                }
                
                self.forgotPasswordView.statusLabel.textColor = UIColor(red: 119/255, green: 175/255, blue: 93/255, alpha: 1)
                self.forgotPasswordView.statusLabel.text = "★ Reset link sent! Check your e-mail."
                self.forgotPasswordView.statusLabel.isHidden = false
                
                self.forgotPasswordView.emailTextfield.text = ""
                
            }
        }, onFailure: { error in
            debugPrint("\(error)")
            
            self.appHelper.dismissAlert()
            self.forgotPasswordView.statusLabel.textColor = .red
            self.forgotPasswordView.statusLabel.text = "Email is invalid."
            self.forgotPasswordView.statusLabel.isHidden = false
            
        })
    }
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: NSNotification){
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        //debugPrint(notification.name.rawValue)
        if(notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification){
            var aRect : CGRect = self.forgotPasswordView.frame
            aRect.size.height -= keyboardRect.height
            
            if let activeField = self.activeField {
                //debugPrint("\(aRect) + \(activeField.frame)")
                if (aRect.contains(activeField.frame.origin)){
                    //debugPrint("keyboard did interfere")
                    self.forgotPasswordView.keyboardHeight = Int(keyboardRect.height)
                    self.forgotPasswordView.isKeyboardShowing = true
                    
                    self.forgotPasswordView.setNeedsUpdateConstraints()
                    self.forgotPasswordView.updateConstraintsIfNeeded()
                }
            }
        }
        
        if(notification.name == UIResponder.keyboardWillHideNotification){
            self.forgotPasswordView.isKeyboardShowing = false
            self.forgotPasswordView.setNeedsUpdateConstraints()
            self.forgotPasswordView.updateConstraintsIfNeeded()
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }


}
