//
//  SpeakersViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 11/01/2019.
//

import UIKit

class SpeakersViewController: UIViewController, SpeakersCollectionViewDelegate {
    
    var speakersView: SpeakersView!
    var speakersCollectionView: SpeakersCollectionView!
    
    let screenSize = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set
        
        speakersView = SpeakersView(frame: CGRect.zero)
        self.view.addSubview(speakersView)
        
        speakersCollectionView = SpeakersCollectionView(frame: CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: screenSize.height))
        speakersCollectionView.delegate = self
        speakersView.addSubview(speakersCollectionView)
        
        // AutoLayout
        speakersView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
    }
    
    // MARK: SpeakersCollectionView Delegate
    func speakersCollectionDidSelect(_ speakersCollectionView: SpeakersCollectionView, indexPathRow: Int) {
        debugPrint("Open Pop up: " + "\(indexPathRow)")
        
        let newViewController = SpeakersBioViewController()
        //self.navigationController?.modal(newViewController, animated: false)
        newViewController.modalPresentationStyle = .overFullScreen
        present(newViewController, animated: false, completion: nil)
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
