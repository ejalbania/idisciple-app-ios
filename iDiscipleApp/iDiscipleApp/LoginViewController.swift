//
//  LoginViewController.swift
//  iDiscipleApp
//
//  Created by eboy on 27/09/2018.
//


import UIKit
import SwiftyJSON


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginView: LoginView!
    var activeField: UITextField?
    
     let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        loginView = LoginView(frame: CGRect.zero)
        self.view.addSubview(loginView)
        
        // AutoLayout
        loginView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        loginView.colorBar.image = UIImage(named: "iDisc_colorBar")
        loginView.mainLogo.image  = UIImage(named: "iDisc_logo")
        
        showHideErrorLabel()
        
        loginView.showPasswordButton.addTarget(self, action: #selector(showPasswordButton), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(moveToForgotPassword), for: .touchUpInside)
        
        //set to logInButtonPressed for actual
        //toMainTabViewTest for testing
        loginView.logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        
        loginView.emailTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        loginView.emailTextfield.delegate = self
        loginView.passwordTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        loginView.passwordTextfield.delegate = self
        
        loginView.logInButton.isUserInteractionEnabled = false
        loginView.logInButton.alpha = 0.5
        
        //Test Input
        //loginView.emailTextfield.text = "ajsumalbag14@gmail.com"
        //loginView.passwordTextfield.text = "1"
        
        //debugPrint(screenSize.height)
        if(screenSize.height <= 667){
            registerForKeyboardNotifications()
        }
        
        self.appHelper.alert(message: "Loading..")
        checkForLoggedUser()
    }
    
    deinit {
        if(screenSize.height <= 667){
            deregisterFromKeyboardNotifications()
        }
     
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func checkForLoggedUser(){
        
        if(UserDefaults.standard.bool(forKey: GlobalConstant.checkLoginState)){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.appHelper.dismissAlert()
                self.moveToMainTabView()
            }
        }else{
            self.appHelper.dismissAlert()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func textfieldDidChange(textField: UITextField) {
        loginView.logInButton.isUserInteractionEnabled = !loginView.emailTextfield.text!.isEmpty && !loginView.passwordTextfield.text!.isEmpty
        
        if(loginView.logInButton.isUserInteractionEnabled){
            loginView.logInButton.alpha = 1
        }else{
            loginView.logInButton.alpha = 0.5
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func showPasswordButton(sender: UIButton!){
        if (loginView.passwordTextfield.isSecureTextEntry){
            loginView.passwordTextfield.isSecureTextEntry = false
            sender.setImage(UIImage(named:"icon_invisible"), for: .normal)
        }
        else{
            loginView.passwordTextfield.isSecureTextEntry = true
            sender.setImage(UIImage(named:"icon_visible"), for: .normal)
        }
    }
    
    @IBAction func moveToForgotPassword(sender: UIButton!){
        
        //hide keyboard
        self.view.endEditing(true)
        
        let newViewController = ForgotPasswordViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    //test
    @IBAction func toFirstTimeUserTest(sender: UIButton!){
        self.view.endEditing(true)
        self.moveToFirstTimeUser()
    }
    
    @IBAction func toMainTabViewTest(sender: UIButton!){
        self.view.endEditing(true)
        self.moveToMainTabView()
    }
    
    @IBAction func logInButtonPressed(sender: UIButton!){
        
        self.view.endEditing(true)
        
        loginView.errorLabel.isHidden = true
        //showHideErrorLabel()
        
        let urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.login
        let paramsDict = ["email": loginView.emailTextfield.text ?? "",
                          "password" : loginView.passwordTextfield.text ?? ""] as [String : Any]
        
        //debugPrint("\(urlString)")
        self.appHelper.alert(message: "Logging in...")
        
        ApiManager.sharedInstance.postDataWithRequest(requestUrl: urlString, params: paramsDict, onSuccess: { json in
            DispatchQueue.main.async {
                
                self.appHelper.dismissAlert()
                self.loginView.errorLabel.isHidden = true
                
                let jsonValue = JSON(json)
                //debugPrint("\(jsonValue["data"])")
                
                for (_, subJson) in jsonValue["data"] {
                    //debugPrint("\(subJson["profile"])")
                    debugPrint("\(subJson["user_account"]["first_time_user"])")
                    
                    if(subJson["user_account"]["first_time_user"].stringValue == "Yes"){
                        //First time User
                        self.createUserProfile(jsonValue: jsonValue)
                        self.moveToFirstTimeUser()
                    }
                    else {
                        //Not first time User
                        debugPrint("\(subJson["user_account"]["token"])")
                        self.createUserProfile(jsonValue: jsonValue)
                        self.moveToMainTabView()
                    }
                    
                    //Is Logged
                    UserDefaults.standard.set(true, forKey: GlobalConstant.checkLoginState)
                }

            }
        }, onFailure: { error in
            debugPrint("\(error)")
            self.appHelper.dismissAlert()
            self.showHideErrorLabel()
        })
    }
    
    func showHideErrorLabel(){
        
        if(loginView.errorLabel.isHidden){
            loginView.errorLabel.isHidden = false
        }
        else{
            loginView.errorLabel.isHidden = true
        }
    }
    
    func createUserProfile(jsonValue:JSON){
        
        for (_, subJson) in jsonValue["data"] {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            let dataDate = dateFormat.date(from:(subJson["profile"]["birthdate"].stringValue))!
            //debugPrint("\(subJson["profile"]["birthdate"])")
            
            let user = User(userID: subJson["user_account"]["user_id"].intValue,
                            userName: subJson["user_account"]["username"].stringValue,
                            firstName: subJson["profile"]["firstname"].stringValue,
                            middleName: subJson["profile"]["middlename"].stringValue,
                            lastName: subJson["profile"]["lastname"].stringValue,
                            nickName: subJson["profile"]["nickname"].stringValue,
                            mobileNo: subJson["profile"]["mobile_no"].stringValue,
                            birthDate: dataDate,
                            gender: subJson["profile"]["gender"].stringValue,
                            country: subJson["profile"]["country"].stringValue,
                            token: subJson["user_account"]["token"].stringValue)
            
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
            UserDefaults.standard.set(encodedData, forKey: "userProfile")
        }
    }
    
    func moveToFirstTimeUser(){
        let newViewController = FirstTimeUserViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func moveToDashboard(){
        let newViewController = DashboardViewController()
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    
    func moveToMainTabView(){
        let newViewController = MainTabBarController()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(newViewController, animated: false)
        //color of default selected tab
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
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
            var aRect : CGRect = self.loginView.frame
            aRect.size.height -= keyboardRect.height
            
            if let activeField = self.activeField {
                //debugPrint("\(aRect) + \(activeField.frame)")
                if (aRect.contains(activeField.frame.origin)){
                    //debugPrint("keyboard did interfere")
                    self.loginView.keyboardHeight = Int(keyboardRect.height)
                    self.loginView.isKeyboardShowing = true
                    
                    self.loginView.setNeedsUpdateConstraints()
                    self.loginView.updateConstraintsIfNeeded()
                }
            }
        }
        
        if(notification.name == UIResponder.keyboardWillHideNotification){
            self.loginView.isKeyboardShowing = false
            self.loginView.setNeedsUpdateConstraints()
            self.loginView.updateConstraintsIfNeeded()
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }

}
