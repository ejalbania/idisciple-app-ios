//
//  MoreViewController.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//

import UIKit

class MoreViewController: UIViewController {
  
  @IBOutlet private weak var moreActivitiesContainer: UIView!
  @IBOutlet private var labelTabs_collection: [UILabel]!
  
  private var pageViewController: MorePageViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.pageViewController?.morePageDelegate = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? MorePageViewController {
      self.pageViewController = viewController
    }
  }
  
  @IBAction func btnTabs_selected(_ sender: UIButton) {
    (0..<2).forEach { self.view.viewWithTag($0)?.isUserInteractionEnabled = false }
    self.pageViewController?.flipToPage(index: sender.tag)
    
    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
      (0...2).forEach { self.view.viewWithTag($0)?.isUserInteractionEnabled = true }
    }
  }
}

// Private Functions
fileprivate extension MoreViewController {
  func highlight_tabButton(withTag tag: Int) {
    labelTabs_collection.forEach { $0.textColor = .lightGray }
    labelTabs_collection[tag].textColor = .black
    self.view.layoutIfNeeded()
  }
}

extension MoreViewController: MorePageViewControllerDelegate {
  func morePage(newIndex index: Int, new viewController: UIViewController) {
    self.highlight_tabButton(withTag: index)
  }
}
