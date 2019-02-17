//
//  WorkshopsViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 28/01/2019.
//

import UIKit
import Popover

class WorkshopsViewController: UIViewController, WorkshopsTableViewDelegate, WorkshopPopOverViewDelegate {

    var workshopView: WorkshopsView!
    //var speakersCollectionView: SpeakersCollectionView!
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Set
        workshopView = WorkshopsView(frame: CGRect.zero)
        self.view.addSubview(workshopView)
        
        // AutoLayout
        workshopView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        workshopView.delegate = self
        workshopView.workshopPopOverView.delegate = self
        
        //workshopView.workshopTableView.reloadData()
        
    }
    
    func showPopOverMenu(fromView: UIView){
        
        workshopView.popOver.show(workshopView.workshopPopOverView, fromView: fromView)
        
    }
    
    //WorkshopView delegate
    func workshopMoreOptionDidPressed(_ workshopsTableView: UITableView, selectedButton: UIButton) {
        debugPrint(selectedButton.tag)
        showPopOverMenu(fromView: selectedButton)

    }
    
    //Workshop pop over delegate
    func workshopPopOverViewDescriptionPressed() {
        debugPrint("view description")
        workshopView.popOver.dismiss()
        
        let newViewController = WorkshopsInfoViewController()
        newViewController.modalPresentationStyle = .overFullScreen
        present(newViewController, animated: false, completion: nil)
    }
    
    func workshopPopOverViewOutlinePressed() {
        debugPrint("view outline")
        workshopView.popOver.dismiss()
    }
    
}
