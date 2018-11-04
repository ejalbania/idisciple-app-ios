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
        
        loginView.errorLabel.isHidden = true
        
        loginView.showPasswordButton.addTarget(self, action: #selector(showPasswordButton), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(moveToForgotPassword), for: .touchUpInside)
        loginView.logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        
        loginView.emailTextfield.text = "noob@gmail.com"
        loginView.passwordTextfield.text = "oE1N1R082OlzEvDB8vLN"
        //showHideErrorLabel()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
    
    @IBAction func logInButtonPressed(sender: UIButton!){
        
        let urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.login
        let paramsDict = ["email": loginView.emailTextfield.text ?? "",
                          "password" : loginView.passwordTextfield.text ?? ""] as [String : Any]
        
        //debugPrint("\(urlString)")
        self.appHelper.alert(message: "Please wait...")
        
        ApiManager.sharedInstance.postDataWithRequest(requestUrl: urlString, params: paramsDict, onSuccess: { json in
            DispatchQueue.main.async {
                
                self.appHelper.dismissAlert()
                
                let jsonValue = JSON(json)
                //debugPrint("\(jsonValue["data"])")
                for (_, subJson) in jsonValue["data"] {
                    //debugPrint("\(subJson["profile"])")
                    debugPrint("\(subJson["user_account"]["first_time_user"])")
                    
                    if(subJson["user_account"]["first_time_user"].stringValue == "Yes"){
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

                        self.moveToFirstTimeUser()
                    }
                    else {
                        //Not first time User
                        self.moveToDashboard()
                    }
                }

            }
        }, onFailure: { error in
            debugPrint("\(error)")
            self.appHelper.dismissAlert()
            self.loginView.errorLabel.isHidden = false
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
    
    func moveToFirstTimeUser(){
        let newViewController = FirstTimeUserViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func moveToDashboard(){
        let newViewController = DashboardViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}
