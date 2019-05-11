//
//  AboutViewController.swift
//  iDiscipleApp
//
//  Created by Rick Roman on 10/05/2019.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

class AboutViewController: UIViewController, IndicatorInfoProvider {
    
    var aboutView: AboutView!
    var itemInfo: IndicatorInfo = "View"

    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        aboutView = AboutView(frame: CGRect.zero)
        self.view.addSubview(aboutView)
        
        // AutoLayout
        aboutView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    

}
