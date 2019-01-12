//
//  LoginViewController.swift
//  iDiscipleApp
//
//  Created by eboy on 27/09/2018.
//


import UIKit
import SwiftyJSON


class LoginViewController: UIViewController {
    
    var loginView: LoginView!
    
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
        loginView.logInButton.addTarget(self, action: #selector(toMainTabViewTest), for: .touchUpInside)
        
        loginView.emailTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        loginView.passwordTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        
        loginView.logInButton.isUserInteractionEnabled = false
        loginView.logInButton.alpha = 0.5
        
        //Test Input
        //loginView.emailTextfield.text = "noob@gmail.com"
        //loginView.passwordTextfield.text = "4IMt7l3Ak7TH9zFiWLe4"
        
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
        let newViewController = ForgotPasswordViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    //test
    @IBAction func toFirstTimeUserTest(sender: UIButton!){
        self.moveToFirstTimeUser()
    }
    
    @IBAction func toMainTabViewTest(sender: UIButton!){
        self.moveToMainTabView()
    }
    
    @IBAction func logInButtonPressed(sender: UIButton!){
        
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
                        self.moveToDashboard()
                    }
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
            
            let user = User(userID: subJson["user_account"]["user_id"].int!,
                            userName: subJson["user_account"]["username"].string!,
                            firstName: subJson["profile"]["firstname"].string!,
                            middleName: subJson["profile"]["middlename"].string!,
                            lastName: subJson["profile"]["lastname"].string!,
                            nickName: subJson["profile"]["nickname"].string!,
                            mobileNo: subJson["profile"]["mobile_no"].string!,
                            birthDate: dataDate,
                            gender: subJson["profile"]["gender"].string!,
                            country: subJson["profile"]["country"].string!,
                            token: subJson["user_account"]["token"].string!)
            
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
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    

}
