//
//  SpeakersViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 11/01/2019.
//

import UIKit

class SpeakersViewController: UIViewController {
    
    var speakersView: SpeakersView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 243/255, green: 137/255, blue: 49/255, alpha: 1)
        
        speakersView = SpeakersView(frame: CGRect.zero)
        self.view.addSubview(speakersView)
        
        // AutoLayout
        speakersView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
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
