//
//  WorkshopsInfoViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 15/02/2019.
//

import UIKit

class WorkshopsInfoViewController: UIViewController {
    
        var workshopInfoView: WorkshopsInfoView!

    override func viewDidLoad() {
        super.viewDidLoad()

        workshopInfoView = WorkshopsInfoView(frame: CGRect.zero)
        self.view.addSubview(workshopInfoView)
        
        workshopInfoView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        //debugPrint(speakersBioView.speakersBioLabel.frame.origin.y)
        //headerLine
        let headerLine = UIBezierPath(rect: CGRect(x: 0, y: 40, width: workshopInfoView.screenSize.width, height: 0.1))
        let headerLayer = CAShapeLayer()
        headerLayer.path = headerLine.cgPath
        headerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        workshopInfoView.mainView.layer.addSublayer(headerLayer)
        
        //footerLine
        let footerLine = UIBezierPath(rect: CGRect(x: 0, y: workshopInfoView.screenSize.height - ((workshopInfoView.screenSize.height/3) + 60), width: workshopInfoView.screenSize.width, height: 0.1))
        let footerLayer = CAShapeLayer()
        footerLayer.path = footerLine.cgPath
        footerLayer.strokeColor =  UIColor.withAlphaComponent(.gray)(0.3).cgColor
        workshopInfoView.mainView.layer.addSublayer(footerLayer)
        
        workshopInfoView.dismissButton.addTarget(self, action: #selector(dismissSpeakersBioView), for: .touchUpInside)
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
