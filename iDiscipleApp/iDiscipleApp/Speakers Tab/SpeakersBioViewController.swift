//
//  SpeakersBioViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 23/01/2019.
//

import UIKit

class SpeakersBioViewController: UIViewController {
    
    var speakersBioView: SpeakersBioView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationController?.isNavigationBarHidden = true
        
        speakersBioView = SpeakersBioView(frame: CGRect.zero)
        self.view.addSubview(speakersBioView)
        
        speakersBioView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        //debugPrint(speakersBioView.speakersBioLabel.frame.origin.y)
        //headerLine
        let headerLine = UIBezierPath(rect: CGRect(x: 0, y: 40, width: speakersBioView.screenSize.width, height: 0.1))
        let headerLayer = CAShapeLayer()
        headerLayer.path = headerLine.cgPath
        headerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        speakersBioView.mainView.layer.addSublayer(headerLayer)
        
        //footerLine
        let footerLine = UIBezierPath(rect: CGRect(x: 0, y: speakersBioView.screenSize.height - ((speakersBioView.screenSize.height/3) + 60), width: speakersBioView.screenSize.width, height: 0.1))
        let footerLayer = CAShapeLayer()
        footerLayer.path = footerLine.cgPath
        footerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        speakersBioView.mainView.layer.addSublayer(footerLayer)
        
        speakersBioView.dismissButton.addTarget(self, action: #selector(dismissSpeakersBioView), for: .touchUpInside)
        
    }
    
    @IBAction func dismissSpeakersBioView(sender: UIButton!){
        dismiss(animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
