//
//  LoginViewController.swift
//  iDiscipleApp
//
//  Created by eboy on 27/09/2018.
//


import UIKit

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
        
        loginView.showPasswordButton.addTarget(self, action: #selector(showPasswordButton), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(moveToForgotPassword), for: .touchUpInside)
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
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
    
}
