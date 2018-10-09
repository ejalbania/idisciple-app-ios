//
//  ForgotPasswordViewController.swift
//  iDiscipleApp
//
//  Created by eboy on 08/10/2018.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    var forgotPasswordView: ForgotPasswordView!
    
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
        
        forgotPasswordView.backToLoginButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backToLogin(sender: UIButton!){
        //let newViewController = ForgotPasswordViewController()
        self.navigationController?.popViewController(animated: true)
    }

}
