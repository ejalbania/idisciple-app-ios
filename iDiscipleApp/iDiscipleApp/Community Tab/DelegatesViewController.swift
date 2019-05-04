//
//  DelegatesViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 27/04/2019.
//

import UIKit
import XLPagerTabStrip

class DelegatesViewController: UIViewController, IndicatorInfoProvider, DelegatesViewDelegate {

    var delegatesView: DelegatesView!
    var itemInfo: IndicatorInfo = "View"
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegatesView = DelegatesView(frame: CGRect.zero)
        delegatesView.delegate = self
        self.view.addSubview(delegatesView)
        
        // AutoLayout
        delegatesView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func delegatesTableViewDidSelectCell(_ delegatesView: DelegatesView, indexPathRow: Int) {
        //Call Pop Up Here
        debugPrint("Open Profile from: " + "\(indexPathRow)")
        
        DispatchQueue.main.async {
            let newViewController = DelegatesProfileViewController()
            //self.navigationController?.modal(newViewController, animated: false)
            newViewController.modalPresentationStyle = .overFullScreen
            self.present(newViewController, animated: false, completion: nil)
        }
        

    }
    
}
