//
//  FirstTimeUserViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/10/2018.
//

import UIKit
import SwiftyJSON

class FirstTimeUserViewController: DownloaderViewController, UITextFieldDelegate {

    var firstTimeUserView: FirstTimeUserView!
    var activeField: UITextField?
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        firstTimeUserView = FirstTimeUserView(frame: CGRect.zero)
        self.view.addSubview(firstTimeUserView)
        
        // AutoLayout
        firstTimeUserView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        firstTimeUserView.colorBar.image = UIImage(named: "iDisc_colorBar")
        firstTimeUserView.mainLogo.image  = UIImage(named: "iDisc_logo")
        
        firstTimeUserView.showNewPasswordButton.addTarget(self, action: #selector(showNewPasswordButton), for: .touchUpInside)
        firstTimeUserView.showReEnterPasswordButton.addTarget(self, action: #selector(showReEnterPasswordButton), for: .touchUpInside)
        
        firstTimeUserView.changeAndGoButton.addTarget(self, action: #selector(changeAndGoButtonPressed), for: .touchUpInside)
        
        //firstTimeUserView.errorLabel.isHidden = true
        firstTimeUserView.newPasswordTextfield.delegate = self
        firstTimeUserView.reEnterPasswordTextfield.delegate = self
        firstTimeUserView.newPasswordTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        firstTimeUserView.reEnterPasswordTextfield.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        
        firstTimeUserView.changeAndGoButton.isUserInteractionEnabled = false
        firstTimeUserView.changeAndGoButton.alpha = 0.5
        
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
        self.navigationController?.isNavigationBarHidden = true
        
        //If logged out
        if(!UserDefaults.standard.bool(forKey: GlobalConstant.checkLoginState)){
            self.navigationController?.popViewController(animated: false)
            //self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func textfieldDidChange(textField: UITextField) {
        firstTimeUserView.changeAndGoButton.isUserInteractionEnabled = !firstTimeUserView.newPasswordTextfield.text!.isEmpty && !firstTimeUserView.reEnterPasswordTextfield.text!.isEmpty && firstTimeUserView.newPasswordTextfield.text?.count ?? 0 > 7 && firstTimeUserView.reEnterPasswordTextfield.text?.count ?? 0 > 7
        
        if(firstTimeUserView.changeAndGoButton.isUserInteractionEnabled){
            firstTimeUserView.changeAndGoButton.alpha = 1
        }else{
            firstTimeUserView.changeAndGoButton.alpha = 0.5
            firstTimeUserView.errorLabel.text = "Minimum password input is 8 characters."
        }
    }
    
    @IBAction func showNewPasswordButton(sender: UIButton!){
        if (firstTimeUserView.newPasswordTextfield.isSecureTextEntry){
            firstTimeUserView.newPasswordTextfield.isSecureTextEntry = false
            sender.setImage(UIImage(named:"icon_invisible"), for: .normal)
        }
        else{
            firstTimeUserView.newPasswordTextfield.isSecureTextEntry = true
            sender.setImage(UIImage(named:"icon_visible"), for: .normal)
        }
    }
    
    @IBAction func showReEnterPasswordButton(sender: UIButton!){
        if (firstTimeUserView.reEnterPasswordTextfield.isSecureTextEntry){
            firstTimeUserView.reEnterPasswordTextfield.isSecureTextEntry = false
            sender.setImage(UIImage(named:"icon_invisible"), for: .normal)
        }
        else{
            firstTimeUserView.reEnterPasswordTextfield.isSecureTextEntry = true
            sender.setImage(UIImage(named:"icon_visible"), for: .normal)
        }
    }
    
    @IBAction func changeAndGoButtonPressed(sender: UIButton!){
        
        self.view.endEditing(true)

        if(firstTimeUserView.newPasswordTextfield.text! != firstTimeUserView.reEnterPasswordTextfield.text!){
            firstTimeUserView.errorLabel.isHidden = false
            firstTimeUserView.errorLabel.text = "Passwords do not match."
        } else{
            //Textfield input is equal
            firstTimeUserView.errorLabel.isHidden = false
            
            let data  = UserDefaults.standard.object(forKey: "userProfile") as! Data
            let loadedUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            
            let urlString = ApiManager.sharedInstance.baseURL + ApiManager.sharedInstance.firstLogPasswordUpdate + "/\(loadedUser.userID)"
            let paramsDict = ["new_password": firstTimeUserView.newPasswordTextfield.text ?? ""] as [String : Any]
            
            self.appHelper.alert(message: "Loading..")
            
            debugPrint(urlString)
            ApiManager.sharedInstance.putDataWithRequest(requestUrl: urlString, params: paramsDict, onSuccess: { json in
                DispatchQueue.main.async {
                    
                    //self.appHelper.dismissAlert()
                    
                    let jsonValue = JSON(json)
                    debugPrint("\(jsonValue["data"]["api_token"])")
                    
                    //Save new api token
                    loadedUser.token = jsonValue["data"]["api_token"].string!
                    //Update user data
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: loadedUser)
                    UserDefaults.standard.set(encodedData, forKey: "userProfile")
                    
                    //Start download
                    self.reloadJsonData(onSuccess: { string in
                        DispatchQueue.main.async {
                            //self.doneReloading()
                        }
                        
                    }, onFailure: { error in
                        debugPrint(error)
                        self.appHelper.dismissAlert()
                    })
                    
                    self.moveToDashboard()
                }
            }, onFailure: { error in
                debugPrint("\(error)")
            })
        }
    }
    
    func moveToDashboard(){
        let newViewController = MainTabBarController()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
        
        self.navigationController?.pushViewController(newViewController, animated: false)
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
            var aRect : CGRect = self.firstTimeUserView.frame
            aRect.size.height -= keyboardRect.height
            
            if let activeField = self.activeField {
                //debugPrint("\(aRect) + \(activeField.frame)")
                if (aRect.contains(activeField.frame.origin)){
                    //debugPrint("keyboard did interfere")
                    self.firstTimeUserView.keyboardHeight = Int(keyboardRect.height)
                    self.firstTimeUserView.isKeyboardShowing = true
                    
                    self.firstTimeUserView.setNeedsUpdateConstraints()
                    self.firstTimeUserView.updateConstraintsIfNeeded()
                }
            }
        }
        
        if(notification.name == UIResponder.keyboardWillHideNotification){
            self.firstTimeUserView.isKeyboardShowing = false
            self.firstTimeUserView.setNeedsUpdateConstraints()
            self.firstTimeUserView.updateConstraintsIfNeeded()
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }

}
