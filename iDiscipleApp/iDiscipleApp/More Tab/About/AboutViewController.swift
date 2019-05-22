//
//  SocialViewController.swift
//  iDiscipleApp
//
//  Created by Emmanuel Albania on 28/04/2019.
//

import UIKit

class AboutViewController: UIViewController {

  @IBOutlet private weak var lblAbout_title: UILabel!
  
  @IBOutlet private weak var tableView: UITableView!
  private let abouts = AboutRepository()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tableView.reloadData()
  }
}

extension AboutViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.abouts.list.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCellView"),
      abouts.list.count >= indexPath.row
       else {
      return UITableViewCell()
    }
    
    let about = self.abouts.list[indexPath.row]
    
    if let titleLabel = cell.viewWithTag(100) as? UILabel,
      let contentLabel = cell.viewWithTag(101) as? UILabel {
      titleLabel.text = about.title
      contentLabel.text = about.content
    }
    
    return cell
  }
  
  
}

extension AboutViewController: UITableViewDelegate {
  
}
