//
//  YourProfileViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 29/04/2019.
//

import UIKit

class YourProfileViewController: UIViewController {

    var yourProfileView: YourProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.navigationController?.isNavigationBarHidden = true
        
        yourProfileView = YourProfileView(frame: CGRect.zero)
        self.view.addSubview(yourProfileView)
        
        yourProfileView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        //debugPrint(speakersBioView.speakersBioLabel.frame.origin.y)
        //headerLine
        let headerLine = UIBezierPath(rect: CGRect(x: 0, y: 40, width: yourProfileView.screenSize.width, height: 0.1))
        let headerLayer = CAShapeLayer()
        headerLayer.path = headerLine.cgPath
        headerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        yourProfileView.mainView.layer.addSublayer(headerLayer)
        
        //footerLine
        let footerLine = UIBezierPath(rect: CGRect(x: 0, y: yourProfileView.screenSize.height - ((yourProfileView.screenSize.height/3) + 60), width: yourProfileView.screenSize.width, height: 0.1))
        let footerLayer = CAShapeLayer()
        footerLayer.path = footerLine.cgPath
        footerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        yourProfileView.mainView.layer.addSublayer(footerLayer)
        
        //footerDividerLine
        let dividerLine = UIBezierPath(rect: CGRect(x: (yourProfileView.screenSize.width/2) - 35, y: yourProfileView.screenSize.height - ((yourProfileView.screenSize.height/3) + 60), width: 0.1, height: 60))
        let dividerLayer = CAShapeLayer()
        dividerLayer.path = dividerLine.cgPath
        dividerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        yourProfileView.mainView.layer.addSublayer(dividerLayer)
        
        yourProfileView.dismissButton.addTarget(self, action: #selector(dismissYourProfileView), for: .touchUpInside)
        
    }
    
    @IBAction func dismissYourProfileView(sender: UIButton!){
        dismiss(animated: false, completion: nil)
    }

}
