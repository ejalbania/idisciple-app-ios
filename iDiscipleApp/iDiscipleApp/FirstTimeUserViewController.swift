//
//  FirstTimeUserViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/10/2018.
//

import UIKit

class FirstTimeUserViewController: UIViewController {

        var firstTimeUserView: FirstTimeUserView!
    
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        let newViewController = DashboardViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

}
